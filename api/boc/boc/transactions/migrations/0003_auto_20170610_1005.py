# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2017-06-10 10:05
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('transactions', '0002_auto_20170610_0953'),
    ]

    operations = [
        migrations.AlterField(
            model_name='merchant',
            name='latitude',
            field=models.DecimalField(decimal_places=5, max_digits=10),
        ),
        migrations.AlterField(
            model_name='merchant',
            name='longitute',
            field=models.DecimalField(decimal_places=5, max_digits=10),
        ),
    ]
