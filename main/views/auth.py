from django.contrib.auth.decorators import login_required
from django.shortcuts import reverse, render
from django.http import HttpResponseRedirect
from django.contrib import messages

from main.forms import SetPasswordForm
from AMS.settings import LOGIN_URL


@login_required(login_url=LOGIN_URL)
def set_password_page(request):
    form = SetPasswordForm(request.POST or None)

    if form.is_valid():
        user = form.save()
        return HttpResponseRedirect(reverse("user-detail", args=[user.id]))

    return render(request, "registration/set_password.html", {
        "form": form,
    })
