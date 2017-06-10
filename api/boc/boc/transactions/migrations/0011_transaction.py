# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2017-06-10 11:36
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('transactions', '0010_merchanttype_icon'),
    ]

    operations = [
        migrations.CreateModel(
            name='Transaction',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('amount', models.DecimalField(decimal_places=2, max_digits=10)),
                ('description', models.CharField(max_length=400)),
                ('transaction_date', models.DateTimeField()),
                ('tags', models.CharField(blank=True, max_length=400, null=True)),
                ('account', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='transactions.Account')),
                ('merchant', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='transactions.Merchant')),
                ('transaction_type', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='transactions.TransactionType')),
            ],
        ),
    ]
