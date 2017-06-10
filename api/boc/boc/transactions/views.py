from django.http import Http404
from rest_framework import mixins, viewsets, status
from rest_framework.response import Response
from rest_framework import permissions

from .models import Account, Customer
from . import serializers


def no_customer_found_404():
    return Response({"success": False,
                     'error_code': 'Customer_NOT_FOUND',
                     "detail": "No customer found!"},
                    status=status.HTTP_404_NOT_FOUND)


class RetrieveAccounts(mixins.ListModelMixin,
                      viewsets.GenericViewSet):
    queryset = Account.objects.all()
    serializer_class = serializers.AccountSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        try:
            customer = self.request.user.customer
            return Account.objects.filter(owner=customer)
        except Customer.DoesNotExist:
            raise Http404

