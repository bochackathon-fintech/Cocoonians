from django.conf.urls import url, include
from rest_framework.routers import DefaultRouter

from . import views

router = DefaultRouter()
router.register(r'accounts', views.RetrieveAccounts, base_name='accounts')

urlpatterns = [
    url(r'^my/', include(router.urls, namespace='myaccounts')),
]