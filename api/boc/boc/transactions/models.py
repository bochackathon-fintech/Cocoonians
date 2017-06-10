from django.db import models
from django.conf import settings
from datetime import date

from dateutil.relativedelta import *
from django.db.models import Sum
from .date_utils import get_first_day_of_month, get_last_day_of_month, get_today_start, get_today_end


class Customer(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, related_name='customer')

    created_date = models.DateField(u'Date created', auto_now_add=True, db_index=True)
    last_update = models.DateTimeField(auto_now=True, db_index=True)
    customer_number = models.CharField(max_length=100)
    email = models.EmailField(max_length=300)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)

    def __str__(self):
        return self.first_name + " " + self.last_name


class MerchantType(models.Model):
    created_date = models.DateField(u'Date created', auto_now_add=True, db_index=True)
    last_update = models.DateTimeField(auto_now=True, db_index=True)
    type = models.CharField(max_length=100)
    icon = models.ImageField(upload_to="mtype_icons", null=True, blank=True)

    def __str__(self):
        return self.type


class Merchant(models.Model):
    created_date = models.DateField(u'Date created', auto_now_add=True, db_index=True)
    last_update = models.DateTimeField(auto_now=True, db_index=True)
    type = models.ForeignKey(MerchantType)
    name = models.CharField(max_length=300)
    merchant_id = models.CharField(max_length=100, db_index=True, unique=True)
    longitute = models.DecimalField(max_digits=12, decimal_places=8)
    latitude = models.DecimalField(max_digits=12, decimal_places=8)

    def __str__(self):
        return self.name


class TransactionType(models.Model):
    code = models.CharField(max_length=4, db_index=True, unique=True)
    name = models.CharField(max_length=40)
    isDebit = models.BooleanField(default=False)
    icon = models.ImageField(upload_to="type_icons", null=True, blank=True)

    def __str__(self):
        return self.name


class Currency(models.Model):
    code = models.CharField(max_length=3, db_index=True, unique=True)
    name = models.CharField(max_length=25)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name_plural = "Currencies"


class AccountCategory(models.Model):
    code = models.CharField(max_length=3, db_index=True, unique=True)
    name = models.CharField(max_length=25)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name_plural = "Account Categories"


class Account(models.Model):
    acount_number = models.CharField(max_length=100)
    # IBAN = models.CharField(max_length=34)
    currency = models.ForeignKey(Currency)
    opening_date = models.DateTimeField(db_index=True)
    name = models.CharField(max_length=25)
    ovedraft_limit = models.DecimalField(decimal_places=2, max_digits=10)
    category = models.ForeignKey(AccountCategory)
    owner = models.ForeignKey(Customer)

    def __str__(self):
        return self.name

    def current_month_snapshots(self):
        year = date.today().year
        month = date.today().month

        month_start = get_first_day_of_month(year, month)
        month_end = get_last_day_of_month(year, month)

        return AccountSnapshot.objects.filter(account=self, date__gte=month_start, date__lte=month_end)

    def balance(self):
        start_date = get_today_start()
        end_date = get_today_end()
        try:
            yesterday_snapshot = AccountSnapshot.objects.get(date=date.today()+relativedelta(days=-1)).balance

            return yesterday_snapshot + Transaction.objects.filter(account=self, transaction_date__gte=start_date, transaction_date__lte=end_date).aggregate(Sum('amount'))["amount__sum"]
        except Exception:
            return 0


class AccountSnapshot(models.Model):
    account = models.ForeignKey(Account, related_name="daily_snapshots")
    date = models.DateField()
    balance = models.DecimalField(decimal_places=2, max_digits=10)

    class Meta:
        unique_together = ('account', 'date')


class Transaction(models.Model):
    account = models.ForeignKey(Account)
    amount = models.DecimalField(decimal_places=2, max_digits=10)
    transaction_type = models.ForeignKey(TransactionType)
    merchant = models.ForeignKey(Merchant, null=True, blank=True)
    description = models.CharField(max_length=400)
    transaction_date = models.DateTimeField(db_index=True)
    tags = models.CharField(max_length=400, null=True, blank=True)

    def __str__(self):
        return self.description
