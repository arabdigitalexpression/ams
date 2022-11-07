from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect
from django.shortcuts import render, get_object_or_404
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
    template_name = 'main/entries/create_form.html'

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


@login_required(login_url='/accounts/login/')
def create_entry(request):
    # create a form instance and populate it with data from the request:
    form = EntryForm(request.POST or None)
    debit_form = EntryDebitItemForm(request.POST or None)
    formset = EntryFormSet(
        request.POST or None,
        debit_amount=request.POST.get('amount', None)
    )

    if form.is_valid() and debit_form.is_valid() and formset.is_valid():
        last_number = AccountingEntry.objects.filter(
            created_at__date=now().date()
        ).order_by('created_at').last()
        entry = AccountingEntry(
            number=last_number.number + 1 if last_number else 1,
            total=debit_form.cleaned_data['amount'],
            description=form.cleaned_data['description'],
            created_by=request.user
        )
        entry.save()
        EntryItem.objects.create(
            is_debit=True, amount=debit_form.cleaned_data['amount'],
            type=debit_form.cleaned_data['type'], entry=entry
        )
        for item in formset:
            EntryItem.objects.create(
                amount=item.cleaned_data['amount'], is_debit=False,
                type=item.cleaned_data['type'], entry=entry,
                project=item.cleaned_data['project']
            )

        messages.success(
            # request, f"{entry.serial_number}تم حفظ القيد برقم "
            request,
            f"{entry.serial_number.translate(str.maketrans('0123456789', '۰١٢٣٤٥٦٧٨٩'))}تم حفظ القيد برقم "
        )
        return HttpResponseRedirect(reverse('entry-list'))

    return render(request, 'main/entries/create_form.html', {
        'formset': formset, 'form': form, 'debit_form': debit_form,
    })


@method_decorator(login_required, name='dispatch')
class AccountingEntryListView(ListView):
    model = AccountingEntry
    paginate_by = 20
    template_name = 'main/entries/list.html'


@method_decorator(login_required, name='dispatch')
class AccountingEntryDetailView(DetailView):
    model = AccountingEntry
    template_name = 'main/entries/detail.html'
