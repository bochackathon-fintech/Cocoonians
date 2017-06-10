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

    def __str__(self):
        return self.name


class Currency(models.Model):
    code = models.CharField(max_length=3, db_index=True, unique=True)
    name = models.CharField(max_length=25)


# class Account(models.Model):
#     IBAN = models.CharField(max_length=34)
#     currency = models.CharField()

# class Transaction(models.Model):
#     user = models.OneToOneField(settings.AUTH_USER_MODEL, related_name='profile')
#
#     created_date = models.DateField(u'Date created', auto_now_add=True, db_index=True)
#     last_update = models.DateTimeField(auto_now=True, db_index=True)
#     customer_number = models.CharField(max_length=100)
#     email = models.EmailField(max_length=300)
#     first_name = models.CharField(max_length=100)
#     last_name = models.CharField(max_length=100)
#
#     def __str__(self):
#         return self.first_name + " " + self.last_name
