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


class SimpleAccountSerializer(serializers.ModelSerializer):
    balance = serializers.DecimalField(max_digits=10, decimal_places=2)
    currency = CurrencySerializer()

    class Meta:
        model = Account
        exclude = ['category']


class AccountSerializer(serializers.ModelSerializer):
    daily_snapshots = AccountSnapshotSerializer(many=True, source='last_30_days_snapshots')
    balance = serializers.DecimalField(max_digits=10, decimal_places=2)
    category = AccountCategorySerializer()
    currency = CurrencySerializer()
    owner = CustomerSerializer()

    class Meta:
        model = Account
        fields = "__all__"


class TransactionTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = TransactionType
        fields = "__all__"


class MerchantTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = MerchantType
        fields = "__all__"


class MerchantSerializer(serializers.ModelSerializer):
    type = MerchantTypeSerializer()

    class Meta:
        model = Merchant
        fields = "__all__"


class TransactionSerializer(serializers.ModelSerializer):
    account = SimpleAccountSerializer()
    transaction_type = TransactionTypeSerializer()
    merchant = MerchantSerializer()

    class Meta:
        model = Transaction
        fields = "__all__"
