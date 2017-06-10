# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin

# Register your models here.
from .models import Customer, Merchant, MerchantType, TransactionType

admin.site.register(Customer)
admin.site.register(MerchantType)
admin.site.register(Merchant)
admin.site.register(TransactionType)