# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin

# Register your models here.
from .models import Customer, Merchant, MerchantType, TransactionType, Currency, AccountCategory, Account
from .models import AccountSnapshot


class AccountSnapshotAdmin(admin.ModelAdmin):
    list_display = ['account', 'date', 'balance']

admin.site.register(Customer)
admin.site.register(MerchantType)
admin.site.register(Merchant)
admin.site.register(TransactionType)
admin.site.register(Currency)
admin.site.register(AccountCategory)
admin.site.register(Account)
admin.site.register(AccountSnapshot,AccountSnapshotAdmin)
