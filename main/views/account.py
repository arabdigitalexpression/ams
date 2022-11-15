from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.db.models import ProtectedError, RestrictedError
from django.http import HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.urls import reverse
from django.utils.decorators import method_decorator
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView, UpdateView

from main.forms import AccountCreateForm, AccountUpdateForm
from main.models import AccountType


@login_required(login_url='/accounts/login/')
def account_list(request):
    accounts = AccountType.objects.filter(parent_account=None)
    return render(request, 'main/account-type/index.html', {
        "accounts": accounts
    })


@login_required(login_url='/accounts/login/')
def account_detail(request, pk):
    account = get_object_or_404(AccountType, id=pk)
    return render(request, 'main/account-type/index.html', {
        "accounts": account.children
    })


@login_required(login_url='/accounts/login/')
def account_create(request):
    form = AccountCreateForm(request.POST or None)
    if form.is_valid():
        account = AccountType(
            name=form.cleaned_data["name"],
            level_type=form.cleaned_data["level_type"],
            balance_type=form.cleaned_data["balance_type"],
            currency=form.cleaned_data["currency"],
            parent_account=form.cleaned_data["parent_account"]
        )
        account.save()
        messages.success(
            request, f'تم إنشاء حساب "{account.name}".'
        )
        return HttpResponseRedirect(reverse(
            "account-type-detail", args=[account.parent_account.id]
        ))
    return render(request, 'main/account-type/form.html', {
        "form": form, "is_update": False
    })


@login_required(login_url='/accounts/login/')
def account_update(request, pk):
    account = get_object_or_404(AccountType, id=pk)
    if request.method == "POST":
        form = AccountUpdateForm(request.POST)
        if form.is_valid():

            account.name = form.cleaned_data["name"]
            account.balance_type = form.cleaned_data["balance_type"]
            account.currency = form.cleaned_data["currency"]
            account.parent_account = form.cleaned_data["parent_account"]
            account.save()
            messages.success(
                request, f'تم تعديل حساب "{account.name}".'
            )
            if account.parent_account is None:
                return HttpResponseRedirect(reverse(
                    "account-type-list"))
            else:
                return HttpResponseRedirect(reverse(
                    "account-type-detail", args=[account.parent_account.id]
                ))
    else:
        form = AccountUpdateForm(initial={
            "name": account.name, "balance_type": account.balance_type,
            "currency": account.currency,
            "parent_account": account.parent_account
        })
    return render(request, 'main/account-type/form.html', {
        "account": account, "form": form, "is_update": True
    })


@login_required(login_url='/accounts/login/')
def delete_account(request, pk):
    if request.POST:
        account = get_object_or_404(AccountType, id=pk)
        if account.is_not_empty:
            messages.warning(
                request, "تحذير: هذا الحساب مرتبط بقيد يومية فلا يمكن مسحه"
            )
            return HttpResponseRedirect(reverse("account-type-list"))
        acc_name = account.name
        try:
            account.delete()
        except (ProtectedError, RestrictedError, ValueError):
            messages.error(request, "عذراً حدث خطأ ما … حاول مرة اخري")
        messages.success(request, f"تم حذف حساب {acc_name}.")
        return HttpResponseRedirect(reverse("account-type-list"))

    return HttpResponseRedirect(reverse("account-type-list"))


@method_decorator(login_required, name='dispatch')
class AccountTypeCreateView(CreateView):
    model = AccountType
    fields = ['name', 'currency']
    template_name = 'main/account-type/create_form.html'


@method_decorator(login_required, name='dispatch')
class AccountTypeUpdateView(UpdateView):
    model = AccountType
    fields = ['name', 'currency']
    template_name = 'main/account-type/update_form.html'


@method_decorator(login_required, name='dispatch')
class AccountTypeListView(ListView):
    model = AccountType
    paginate_by = 20
    template_name = 'main/account-type/index.html'


@method_decorator(login_required, name='dispatch')
class AccountTypeDetailView(DetailView):
    model = AccountType
    template_name = 'main/account-type/detail.html'
