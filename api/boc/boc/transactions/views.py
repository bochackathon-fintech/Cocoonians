from django.http import Http404
from datetime import datetime
from rest_framework import mixins, viewsets, status
from rest_framework.response import Response
from rest_framework import permissions

from .models import Account, Customer, Transaction
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


class RetrieveTransactions(mixins.ListModelMixin,
                           viewsets.GenericViewSet):
    queryset = Transaction.objects.all()
    serializer_class = serializers.TransactionSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        account_id = self.request.query_params.get('account_id', None)

        start_date = None
        start_date_str = self.request.query_params.get('start_date', None)
        if start_date_str:
            start_date = datetime.strptime(start_date_str, '%d-%m-%Y')

        end_date = None
        end_date_str = self.request.query_params.get('end_date', None)
        if end_date_str:
            end_date = datetime.strptime(end_date_str, '%d-%m-%Y')

        try:
            customer = self.request.user.customer
            queryset = Transaction.objects.filter(account__owner=customer)
            if account_id:
                queryset = queryset.filter(account__pk=account_id)
            if start_date and end_date:
                queryset = queryset.filter(transaction_date__gte=start_date, transaction_date__lte=end_date)
            return queryset.order_by("-transaction_date")
        except Customer.DoesNotExist:
            raise Http404
