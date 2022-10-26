from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView, UpdateView
from main.models import Project


@method_decorator(login_required, name='dispatch')
class ProjectCreateView(CreateView):
    model = Project
    fields = ['name']
    template_name = 'main/project/create_form.html'


@method_decorator(login_required, name='dispatch')
class ProjectUpdateView(UpdateView):
    model = Project
    fields = ['name']
    template_name = 'main/project/update_form.html'


@method_decorator(login_required, name='dispatch')
class ProjectListView(ListView):
    model = Project
    paginate_by = 20
    template_name = 'main/project/list.html'


@method_decorator(login_required, name='dispatch')
class ProjectDetailView(DetailView):
    model = Project
    template_name = 'main/project/detail.html'
