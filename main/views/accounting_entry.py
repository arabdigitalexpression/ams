from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView

from main.forms import EntryFormSet
from main.models import AccountingEntry


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


@method_decorator(login_required, name='dispatch')
class AccountingEntryListView(ListView):
    model = AccountingEntry
    paginate_by = 20
    template_name = 'main/entries/list.html'


@method_decorator(login_required, name='dispatch')
class AccountingEntryDetailView(DetailView):
    model = AccountingEntry
    template_name = 'main/entries/detail.html'
