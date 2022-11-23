from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.decorators import permission_required
from django.contrib.auth.mixins import PermissionRequiredMixin

from main.decorators import owner_or_superuser_required
from main.models import User
from django.db.models import ProtectedError, RestrictedError
from django.http import HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.urls import reverse
from django.utils.decorators import method_decorator
from django.views.generic import ListView

from main.forms import UserForm


@login_required
@permission_required("auth.add_user")
def user_create(request):
    form = UserForm(request.POST or None)
    if form.is_valid():
        user = form.save()
        rand_password = User.objects.make_random_password()
        user.set_password(rand_password)
        user.save()
        messages.success(
            request, f'تم إنشاء مستخدم "{user.get_full_name()}".'
        )
        return render(request, "main/user/success.html", {
            "username": user.username, "password": rand_password, "fullname": user.get_full_name
        })
    return render(request, "main/user/form.html", {
        "form": form, "is_update": False
    })


@login_required
@owner_or_superuser_required
def user_update(request, pk):
    user = get_object_or_404(User, id=pk)
    form = UserForm(request.POST or None, instance=user)
    if form.is_valid():
        form.save()
        messages.success(
            request, f'تم تعديل المستخدم "{user.get_full_name()}".'
        )
        return HttpResponseRedirect(reverse("user-list"))
    return render(request, 'main/user/form.html', {
        "user": user, "form": form, "is_update": True
    })


@login_required
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


@login_required
def user_detail(request, pk):
    user = get_object_or_404(User, id=pk)
    return render(request, "main/user/detail.html", {"user": user})
