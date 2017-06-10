from dateutil.relativedelta import *
from datetime import date
from django.utils import timezone


def get_this_week_ms():
    today = get_today_start()

    if today.isoweekday() == 1:
        monday_this_week = today
    else:
        monday_this_week = today+relativedelta(weeks=-1, weekday=MO)
    sunday_this_week = (today+relativedelta(weekday=SU)).replace(hour=23, minute=59, second=59)

    return monday_this_week, sunday_this_week


def get_last_week_ms():

    oneweekago = get_one_week_ago()

    if oneweekago.isoweekday() == 1:
        monday_last_week = oneweekago+relativedelta(weeks=-1, weekday=MO)
    else:
        monday_last_week = oneweekago
    sunday_last_week = (oneweekago+relativedelta(weekday=SU)).replace(hour=23, minute=59, second=59)
    

    return monday_last_week, sunday_last_week


def get_week_year(day):
    year = day.year
    week = day.isocalendar()[1]

    return week, year


def get_today_start():
    return timezone.now().replace(hour=0, minute=0, second=0)


def get_today_end():
    return timezone.now().replace(hour=23, minute=59, second=59)


def get_one_week_ago():
    today = get_today_start()
    oneweekago = today+relativedelta(weeks=-1)

    return oneweekago


def get_first_day_of_month(year, month):
    return date(year, month, 1)


def get_last_day_of_month(year, month):
        return get_first_day_of_month(year, month) + relativedelta(months=1, days=-1)


def get_current_year():
    return date.today().year