from django.utils.encoding import force_text

from rest_framework.authentication import SessionAuthentication, exceptions
from rest_framework import status


class CSessionValidationError(exceptions.APIException):
    status_code = status.HTTP_403_FORBIDDEN

    def __init__(self, detail):
        self.detail = detail

    def __str__(self):
        return force_text(self.detail)


class CSessionAuthentication(SessionAuthentication):
    def enforce_csrf(self, request):
        """
        Enforce CSRF validation for session based authentication.
        """
        return True

