# from django.urls import path
# from django.contrib.auth import views as auth_views
from rest_framework.routers import DefaultRouter
from .views import (
    UserViewSet, ProjectViewSet, LabelViewSet, AccountTypeViewSet,
    AccountingEntryViewSet, EntryItemViewSet,
    # setupView
)

user_router = DefaultRouter()
user_router.register(r'users', UserViewSet, basename='user')

project_router = DefaultRouter()
project_router.register(r'projects', ProjectViewSet, basename='project')

label_router = DefaultRouter()
label_router.register(r'labels', LabelViewSet, basename='label')

account_type_router = DefaultRouter()
account_type_router.register(r'account-types', AccountTypeViewSet, basename='accounttype')

entry_router = DefaultRouter()
entry_router.register(r'entries', AccountingEntryViewSet, basename='accountingentry')

entry_item_router = DefaultRouter()
entry_item_router.register(r'entry-items', EntryItemViewSet, basename='entryitem')


urlpatterns = user_router.urls
urlpatterns += project_router.urls
urlpatterns += label_router.urls
urlpatterns += account_type_router.urls
urlpatterns += entry_router.urls
urlpatterns += entry_item_router.urls
urlpatterns += [
    # TODO: the setup route here are for first time web app setup wizard.
    # path('setup/', setupView, name="setup"),

    # path('login/', auth_views.LoginView.as_view(template_name='login.html'), name='login'),

]
