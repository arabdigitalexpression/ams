from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.db.models import ProtectedError, RestrictedError
from django.http import HttpResponseRedirect
from django.shortcuts import render, get_object_or_404
from django.urls import reverse
from django.utils.decorators import method_decorator
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView, UpdateView

from main.forms import ProjectForm
from main.models import Project
from AMS.settings import LOGIN_URL


@login_required(login_url=LOGIN_URL)
def project_index(request):
    projects = Project.objects.all()
    if request.method == "POST":
        form = ProjectForm(request.POST)
        if form.is_valid():
            project = Project(name=form.cleaned_data["name"])
            project.save()
            messages.success(request, f"تم إنشاء مشروع \"{project.name}\".")
            return HttpResponseRedirect(reverse("project-list"))
        else:
            messages.error(request, "عذراً حدث خطأ ما … حاول مرة اخري")
        return render(request, 'main/project/index.html', {
            "form": form, "projects": projects, "is_update": False
        })
    else:
        form = ProjectForm()
        return render(request, 'main/project/index.html', {
            "form": form, "projects": projects, "is_update": False
        })


@login_required(login_url=LOGIN_URL)
def project_update(request, pk):
    projects = Project.objects.all()
    project = get_object_or_404(Project, id=pk)
    if request.method == "POST":
        form = ProjectForm(request.POST)
        if form.is_valid():
            project.name = form.cleaned_data["name"]
            project.save()
            messages.success(request, f"تم تعديل مشروع \"{project.name}\".")
            return HttpResponseRedirect(reverse("project-list"))
        else:
            messages.error(request, "عذراً حدث خطأ ما … حاول مرة اخري")
        return render(request, 'main/project/index.html', {
            "form": form, "projects": projects,
            "project": project, "is_update": True
        })
    else:
        form = ProjectForm(initial={"name": project.name})
        return render(request, 'main/project/index.html', {
            "form": form, "projects": projects,
            "project": project, "is_update": True
        })


@login_required(login_url=LOGIN_URL)
def delete_project(request, pk):
    if request.POST:
        project = get_object_or_404(Project, id=pk)
        if project.items.count() > 0:
            messages.warning(
                request, f"تحذير: مشروع \"{project.name}\" مرتبط بقيد يومية فلا يمكن مسحه"
            )
            return HttpResponseRedirect(reverse("project-list"))
        proj_name = project.name
        try:
            project.delete()
        except (ProtectedError, RestrictedError, ValueError):
            messages.error(request, "عذراً حدث خطأ ما … حاول مرة اخري")
        messages.success(request, f"تم حذف مشروع \"{proj_name}\".")
        return HttpResponseRedirect(reverse("project-list"))

    return HttpResponseRedirect(reverse("project-list"))


@method_decorator(login_required, name='dispatch')
class ProjectCreateView(CreateView):
    model = Project
    fields = ['name']
    template_name = 'main/project/form.html'


@method_decorator(login_required, name='dispatch')
class ProjectUpdateView(UpdateView):
    model = Project
    fields = ['name']
    template_name = 'main/project/update_form.html'


@method_decorator(login_required, name='dispatch')
class ProjectListView(ListView):
    model = Project
    paginate_by = 20
    template_name = 'main/project/index.html'


@method_decorator(login_required, name='dispatch')
class ProjectDetailView(DetailView):
    model = Project
    template_name = 'main/project/detail.html'
