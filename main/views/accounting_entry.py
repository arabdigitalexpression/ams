from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse
from django.utils.decorators import method_decorator
from django.utils.timezone import now
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView

from main.forms import EntryFormSet, EntryForm, EntryDebitItemForm
from main.models import AccountingEntry, EntryItem


@method_decorator(login_required, name='dispatch')
class AccountingEntryCreateView(CreateView):
    model = AccountingEntry
    fields = ["description"]
    template_name = 'main/entries/form.html'

    def get_context_data(self, **kwargs):
        # we need to overwrite get_context_data
        # to make sure that our formset is rendered
        data = super().get_context_data(**kwargs)
        if self.request.POST:
            data["items"] = EntryFormSet(self.request.POST)
        else:
            data["items"] = EntryFormSet()
        return data

    def form_valid(self, form):
        context = self.get_context_data()
        items = context["items"]
        self.object = form.save()
        if items.is_valid():
            items.instance = self.object
            items.save()
        return super().form_valid(form)


@login_required
def create_entry(request):
    # create a form instance and populate it with data from the request:
    form = EntryForm(request.POST or None)
    debit_form = EntryDebitItemForm(request.POST or None)
    formset = EntryFormSet(
        request.POST or None,
        debit_amount=request.POST.get('debit_amount', None),
        debit_account=request.POST.get('debit_account', None)
    )

    if form.is_valid() and debit_form.is_valid() and formset.is_valid():
        last_number = AccountingEntry.objects.filter(
            created_at__date=now().date()
        ).order_by('created_at').last()
        entry = AccountingEntry(
            number=last_number.number + 1 if last_number else 1,
            total=debit_form.cleaned_data['debit_amount'],
            description=form.cleaned_data['description'],
            created_by=request.user
        )
        entry.save()
        for item in formset:
            EntryItem.objects.create(
                debit_amount=debit_form.cleaned_data['debit_amount'],
                debit_account=debit_form.cleaned_data['debit_account'],
                credit_amount=item.cleaned_data['credit_amount'],
                credit_account=item.cleaned_data['credit_account'],
                project=item.cleaned_data['project'], entry=entry,
            )

        from main.utils import convert_nums_to_arabic
        messages.success(
            request,
            f"تم حفظ القيد برقم {convert_nums_to_arabic(entry.serial_number)}"
        )
        return HttpResponseRedirect(reverse('entry-list'))

    return render(request, 'main/entries/form.html', {
        'formset': formset, 'form': form, 'debit_form': debit_form,
    })


@method_decorator(login_required, name='dispatch')
class AccountingEntryListView(ListView):
    model = AccountingEntry
    paginate_by = 20
    template_name = 'main/entries/index.html'


@method_decorator(login_required, name='dispatch')
class AccountingEntryDetailView(DetailView):
    model = AccountingEntry
    template_name = 'main/entries/detail.html'
