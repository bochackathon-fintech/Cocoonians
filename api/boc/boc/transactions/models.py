from django.db import models
from django.conf import settings


class Customer(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, related_name='profile')

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
    longitute = models.DecimalField(max_digits=10, decimal_places=5)
    latitude = models.DecimalField(max_digits=10, decimal_places=5)

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

    def balance(self):
        #TODO
        return 0


class AccountSnapshot(models.Model):
    account = models.ForeignKey(Account)
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
    transaction_date = models.DateTimeField()
    tags = models.CharField(max_length=400, null=True, blank=True)

    def __str__(self):
        return self.description
