from django.contrib.auth.models import Group, Permission
from django.contrib.auth.decorators import login_required, user_passes_test
from django.shortcuts import reverse, render, get_object_or_404
from django.http import HttpResponseRedirect
from django.contrib import messages

from AMS.settings import LOGIN_REDIRECT_URL
from main.forms import SetPasswordForm, GroupPermissionForm
from main.models import User


@login_required
def user_profile(request):
    return render(request, "main/user/profile.html")


# TODO: combine login_required with user_passes_test
# the login_url and redirect_field_name in user_passes_test isn't good
@login_required
@user_passes_test(
    lambda user: user.is_reset_password,
    login_url=LOGIN_REDIRECT_URL,
    redirect_field_name=None
)
def set_password_page(request):
    form = SetPasswordForm(
        user=request.user, data=request.POST or None
    )

    if form.is_valid():
        user = form.save()
        return HttpResponseRedirect(reverse("user-detail", args=[user.id]))

    return render(request, "registration/set_password.html", {
        "form": form,
    })


@login_required
@user_passes_test(
    lambda user: user.is_superuser,
    login_url=LOGIN_REDIRECT_URL,
    redirect_field_name=None
)
def reset_user_password(request, pk):
    user = get_object_or_404(User, id=pk)
    if request.method == "POST":
        rand_password = User.objects.make_random_password()
        user.set_password(rand_password)
        user.save()
        messages.success(
            request, f'تم تغيير كلمة مرور "{user.get_full_name()}".'
        )
        return render(request, "main/user/success.html", {
            "username": user.username, "password": rand_password,
            "fullname": user.get_full_name,
        })
    return HttpResponseRedirect(reverse("user-list"))


@login_required
@user_passes_test(
    lambda user: user.is_superuser,
    login_url=LOGIN_REDIRECT_URL,
    redirect_field_name=None
)
def list_group(request):
    groups = Group.objects.all()
    return render(request, "main/auth/index.html", {
        "groups": groups,
    })


@login_required
@user_passes_test(
    lambda user: user.is_superuser,
    login_url=LOGIN_REDIRECT_URL,
    redirect_field_name=None
)
def create_group(request):
    form = GroupPermissionForm(request.POST or None)

    if form.is_valid():
        form.save()
        return HttpResponseRedirect(reverse("group-list"))

    return render(request, "main/auth/form.html", {
        "form": form, "is_update": False,
    })


@login_required
@user_passes_test(
    lambda user: user.is_superuser,
    login_url=LOGIN_REDIRECT_URL,
    redirect_field_name=None
)
def update_group(request, pk):
    group = get_object_or_404(Group, id=pk)
    form = GroupPermissionForm(request.POST or None, instance=group)

    if form.is_valid():
        # form.save()
        return HttpResponseRedirect(reverse("group-list"))

    return render(request, "main/auth/form.html", {
        "form": form, "is_update": True, "group": group
    })
