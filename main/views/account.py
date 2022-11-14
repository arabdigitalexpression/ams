from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView, UpdateView
from main.models import AccountType


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
    template_name = 'main/account-type/list.html'


@method_decorator(login_required, name='dispatch')
class AccountTypeDetailView(DetailView):
    model = AccountType
    template_name = 'main/account-type/detail.html'
