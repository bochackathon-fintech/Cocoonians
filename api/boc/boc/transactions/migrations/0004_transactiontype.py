# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2017-06-10 10:10
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('transactions', '0003_auto_20170610_1005'),
    ]

    operations = [
        migrations.CreateModel(
            name='TransactionType',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.CharField(max_length=4)),
                ('name', models.CharField(max_length=40)),
                ('isDebit', models.BooleanField(default=False)),
            ],
        ),
    ]
