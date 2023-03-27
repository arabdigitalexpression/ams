from datetime import datetime, timedelta
from itertools import groupby

# from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from django.db.models import Prefetch, F, Q, Sum
from django.http import Http404
from django.shortcuts import render

from main.forms import LedgerFilterForm, TrialBalanceFilterForm
from main.models import AccountType, EntryItem


# TODO: main.show_account_ledger permission doesn't exist, add it to the init fixture
@login_required
def account_ledger(request, pk):
    from_date = request.GET.get("from", None)
    to_date = request.GET.get("to", None)
    to_date_fixed = None
    if from_date:
        from_date = datetime.strptime(from_date, "%Y-%m-%d")
    if to_date:
        to_date = datetime.strptime(to_date, "%Y-%m-%d")
        # strptime have minutes and seconds zero valued, so we add a day
        to_date_fixed = to_date + timedelta(days=1)

    try:
        # TODO: user values or values_list to return only needed data
        account = AccountType.objects \
            .select_related("currency", "parent_account") \
            .prefetch_related(
                Prefetch(
                    "credit_items__entry",
                    queryset=EntryItem.objects.filter(
                        entry__created_at__range=(from_date, to_date_fixed)
                    ),
                    to_attr="credit_items"
                ),
                Prefetch(
                    "debit_items__entry",
                    queryset=EntryItem.objects.filter(
                        entry__created_at__range=(from_date, to_date_fixed)
                    ),
                    to_attr="debit_items"
                ),
                "credit_items__project",
                "debit_items__project") \
            .get(id=pk)
    except AccountType.DoesNotExist:
        raise Http404()

    credit_items = account.credit_items\
        .annotate(
            amount=F("credit_amount"),
            account_name=F("debit_account__name"),
            number=F("entry__number"),
            created_at=F("entry__created_at"),
        )\
        .values(
            "amount", "account_name",
            "number", "created_at"
        )
    debit_items = account.debit_items\
        .annotate(
            amount=F("credit_amount"),
            account_name=F("credit_account__name"),
            number=F("entry__number"),
            created_at=F("entry__created_at"),
        )\
        .values(
            "amount", "account_name",
            "number", "created_at"
        )

    dates = [item["created_at"] for item in [*credit_items, *debit_items]]
    if dates:
        from_date = min(dates)
        to_date_fixed = max(dates)

    credit_total = sum([item["amount"] for item in credit_items])
    debit_total = sum([item["amount"] for item in debit_items])
    total_diff = abs(credit_total - debit_total)
    total = max(credit_total, debit_total)
    is_credit_gt = credit_total > debit_total

    return render(request, "main/ledger/account_ledger.html", {
        "account": account, "from_date": from_date, "to_date": to_date_fixed,
        "credit_items": credit_items, "debit_items": debit_items,
        "total_diff": total_diff, "is_credit_gt": is_credit_gt,
        "total": total,
    })


@login_required
def ledger_page(request):
    form = LedgerFilterForm(request.POST or None)

    if form.is_valid():
        from_date = form.cleaned_data.get("from_date")
        to_date = form.cleaned_data.get("to_date")
        project_id = form.cleaned_data.get("project")
        account_id = form.cleaned_data.get("account")

        project_query = Q()
        from_date_query = Q()
        to_date_query = Q()
        if project_id:
            project_query = Q(project__id=project_id)

        if from_date:
            from_date_query = Q(entry__created_at__gt=from_date)
        if to_date:
            # added 1 day because date object have time set to 00:00 (i.e. beginning of day)
            to_date_query = Q(entry__created_at__lt=(to_date + timedelta(days=1)))

        account = AccountType.objects \
            .select_related("currency", "parent_account") \
            .get(id=account_id)

        credit_items = EntryItem.objects \
            .filter(
                from_date_query, to_date_query,
                project_query, credit_account=account,
            ) \
            .annotate(
                amount=F("credit_amount"),
                account_name=F("debit_account__name"),
                project_name=F("project__name"),
                number=F("entry__number"),
                created_at=F("entry__created_at"),
            ) \
            .values(
                "amount", "account_name", "project_name",
                "number", "created_at"
            )

        debit_items = EntryItem.objects \
            .filter(
                from_date_query, to_date_query,
                project_query, debit_account=account
            ) \
            .annotate(
                amount=F("credit_amount"),
                account_name=F("credit_account__name"),
                project_name=F("project__name"),
                number=F("entry__number"),
                created_at=F("entry__created_at"),
            ) \
            .values(
                "amount", "account_name", "project_name",
                "number", "created_at"
            )

        dates = [item["created_at"] for item in [*credit_items, *debit_items]]
        if dates:
            from_date = min(dates)
            to_date = max(dates)

        credit_total = sum([item["amount"] for item in credit_items])
        debit_total = sum([item["amount"] for item in debit_items])
        total_diff = abs(credit_total - debit_total)
        total = max(credit_total, debit_total)
        is_credit_gt = credit_total > debit_total

        return render(request, "main/ledger/account_ledger.html", {
            "account": account, "from_date": from_date, "to_date": to_date,
            "credit_items": credit_items, "debit_items": debit_items,
            "total_diff": total_diff, "is_credit_gt": is_credit_gt,
            "total": total,
        })

    return render(request, "main/ledger/index.html", {
        "form": form, "report_type": "ledger"
    })


@login_required
def trial_balance(request):
    form = TrialBalanceFilterForm(request.POST or None)

    if form.is_valid():
        from_date = form.cleaned_data.get("from_date")
        to_date = form.cleaned_data.get("to_date")
        from_date_query = Q()
        to_date_query = Q()

        if from_date:
            from_date_query = Q(entry__created_at__gt=from_date)
        if to_date:
            # added 1 day because date object have time set to 00:00 (i.e. beginning of day)
            to_date_query = Q(entry__created_at__lt=(to_date + timedelta(days=1)))

        credit_items = list(EntryItem.objects.filter(
            from_date_query, to_date_query
        ).values('credit_account_id').annotate(
            acc_id=F('credit_account_id'), name=F('credit_account__name'),
            sum=Sum('credit_amount'), type=F('credit_account__balance_type')
        ))
        debit_items = list(EntryItem.objects.filter(
            from_date_query, to_date_query
        ).values('debit_account_id').annotate(
            acc_id=F('debit_account_id'), name=F('debit_account__name'),
            sum=Sum('debit_amount'), type=F('debit_account__balance_type')
        ))

        items = list()
        idx = list()
        res = list()

        for credit_item in credit_items:
            items.append({
                "id": credit_item["acc_id"], "name": credit_item["name"],
                "sum": credit_item["sum"], "is_debit": False,
                "type": credit_item["type"]
            })
        for debit_item in debit_items:
            items.append({
                "id": debit_item["acc_id"], "name": debit_item["name"],
                "sum": debit_item["sum"], "is_debit": True,
                "type": debit_item["type"]
            })

        balance_totals = groupby(sorted(
            items, key=lambda x: x['id']
        ), lambda x: x['id'])
        totals = list()
        for pk, group in balance_totals:
            group_items = [dict(item) for item in group]
            totals.append((
                pk, sorted(group_items, key=lambda x: x['is_debit'])
            ))

        for item in items:
            if item['id'] not in idx:
                idx.append(item['id'])
                res.append(item)
            else:
                index = idx.index(item['id'])
                res[index]['sum'] = res[index]['sum'] - item['sum']

        total = sum([
            item["sum"] for item in res if item['is_debit'] is True
        ])

        return render(request, "main/ledger/trial_balance.html", {
            "from_date": from_date, "to_date": to_date, "total": total,
            "trial_balance": res, "totals": totals,
        })

    return render(request, "main/ledger/index.html",  {
        "form": form, "report_type": "trial_balance"
    })
