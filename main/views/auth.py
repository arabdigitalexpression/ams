from django.contrib.auth.decorators import login_required, user_passes_test
from django.shortcuts import reverse, render
from django.http import HttpResponseRedirect
from django.contrib import messages

from main.forms import SetPasswordForm, GroupPermissionForm


@login_required
@user_passes_test(lambda user: user.is_reset_password)
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


# @login_required
# @user_passes_test(lambda user: user.is_superuser)
# def create_group(request):
#     form = GroupPermissionForm(request.POST or None)
#
#     if form.is_valid():
#         user = form.save()
#         return HttpResponseRedirect(reverse("user-detail", args=[user.id]))
#
#     return render(request, "registration/set_password.html", {
#         "form": form,
#     })
