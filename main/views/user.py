from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import PermissionRequiredMixin
from django.contrib.auth.models import User
from django.contrib.auth.decorators import permission_required
from django.db.models import ProtectedError, RestrictedError
from django.http import HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.urls import reverse
from django.utils.decorators import method_decorator
from django.views.generic import ListView, DetailView

from main.forms import UserForm


@login_required(login_url="/users/login/")
@permission_required("auth.add_user")
def user_create(request):
    form = UserForm(request.POST or None)
    if form.is_valid():
        user = User(
            first_name=form.cleaned_data["first_name"],
            last_name=form.cleaned_data["last_name"],
            username=form.cleaned_data["username"],
            group=form.cleaned_data["group"],
            email=form.cleaned_data["email"],
        )
        # TODO: generate random password then return it to success templates
        rand_password = "35715900"
        user.set_password(rand_password)
        user.save()
        messages.success(
            request, f'تم إنشاء مستخدم "{user.get_full_name()}".'
        )
        return render(request, "main/user/success.html", {
            "username": user.username, "password": rand_password
        })
    return render(request, "main/user/form.html", {
        "form": form, "is_update": False
    })


@login_required(login_url='/users/login/')
@permission_required("auth.change_user")
def user_update(request, pk):
    user = get_object_or_404(User, id=pk)
    if request.method == "POST":
        form = UserForm(request.POST)
        if form.is_valid():
            user.first_name = form.cleaned_data["first_name"]
            user.last_name = form.cleaned_data["last_name"]
            user.email = form.cleaned_data["email"]
            user.username = form.cleaned_data["username"]
            user.group = form.cleaned_data["group"]
            user.save()
            messages.success(
                request, f'تم تعديل المستخدم "{user.get_full_name()}".'
            )
            return HttpResponseRedirect(reverse("user-list"))
    else:
        form = UserForm(initial={
            "first_name": user.first_name, "last_name": user.last_name,
            "email": user.email, "username": user.username,
            "group": user.group,
        })
    return render(request, 'main/user/form.html', {
        "user": user, "form": form, "is_update": True
    })


@login_required(login_url='/users/login/')
@permission_required("auth.delete_user")
def delete_user(request, pk):
    if request.POST:
        user = get_object_or_404(User, id=pk)
        # if user.is_not_empty:
        #     messages.warning(
        #         request, "تحذير: هذا المستخدم مرتبط بقيد يومية فلا يمكن مسحه"
        #     )
        #     return HttpResponseRedirect(reverse("user-list"))
        user_name = user.username
        try:
            user.delete()
        except (ProtectedError, RestrictedError, ValueError):
            messages.error(request, "عذراً حدث خطأ ما … حاول مرة اخري")
        messages.success(request, f"تم حذف المستخدم {user_name}.")
        return HttpResponseRedirect(reverse("user-list"))

    return HttpResponseRedirect(reverse("user-list"))


@method_decorator(login_required, name='dispatch')
class UserListView(PermissionRequiredMixin, ListView):
    model = User
    paginate_by = 5
    permission_required = "auth.view_user"
    template_name = 'main/user/index.html'


@method_decorator(login_required, name='dispatch')
class UserDetailView(PermissionRequiredMixin, DetailView):
    model = User
    permission_required = "auth.view_user"
    template_name = 'main/user/detail.html'
