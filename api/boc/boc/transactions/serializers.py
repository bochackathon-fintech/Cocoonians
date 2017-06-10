from rest_framework import serializers
from .models import Customer, Merchant, MerchantType, TransactionType, Currency, AccountCategory, Account
from .models import AccountSnapshot, Transaction


class CurrencySerializer(serializers.ModelSerializer):
    class Meta:
        model = Currency
        fields = "__all__"


class AccountCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = AccountCategory
        fields = "__all__"


class CustomerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = "__all__"


class AccountSnapshotSerializer(serializers.ModelSerializer):
    class Meta:
        model = AccountSnapshot
        fields = "__all__"


class AccountSerializer(serializers.ModelSerializer):
    daily_snapshots = AccountSnapshotSerializer(many=True, source='current_month_snapshots')
    balance = serializers.DecimalField(max_digits=10, decimal_places=2)
    category = AccountCategorySerializer()
    currency = CurrencySerializer()
    owner = CustomerSerializer()

    class Meta:
        model = Account
        fields = "__all__"


class TransactionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Transaction
        fields = "__all__"
