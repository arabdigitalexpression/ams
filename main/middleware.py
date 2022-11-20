from django.http import HttpResponseRedirect
from django.urls import reverse


class PasswordSetMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)
        next_url = reverse('set-password')
        if request.user.is_authenticated and request.path != next_url:
            if request.user.is_reset_password:
                return HttpResponseRedirect(next_url)

        return response
