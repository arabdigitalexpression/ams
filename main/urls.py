from django.urls import path
from django.contrib.auth import views as auth_views
from rest_framework.routers import DefaultRouter

from .forms import LoginForm
from .views import (
    UserViewSet, ProjectViewSet, AccountTypeViewSet,
    AccountingEntryViewSet, EntryItemViewSet, ProjectDetailView,
    ProjectListView, ProjectCreateView, ProjectUpdateView,
    AccountTypeListView, AccountTypeDetailView,
    AccountTypeUpdateView, AccountTypeCreateView,
    AccountingEntryCreateView, AccountingEntryListView,
    AccountingEntryDetailView,
    # setupView
)
from .views.accounting_entry import create_entry
from .views.project import project_index, project_update, delete_project

user_router = DefaultRouter()
user_router.register(r'api/users', UserViewSet, basename='user')

project_router = DefaultRouter()
project_router.register(r'api/projects', ProjectViewSet, basename='project')

account_type_router = DefaultRouter()
account_type_router.register(r'api/account-types', AccountTypeViewSet, basename='accounttype')

entry_router = DefaultRouter()
entry_router.register(r'api/entries', AccountingEntryViewSet, basename='accountingentry')

entry_item_router = DefaultRouter()
entry_item_router.register(r'api/entry-items', EntryItemViewSet, basename='entryitem')


urlpatterns = user_router.urls
urlpatterns += project_router.urls
urlpatterns += account_type_router.urls
urlpatterns += entry_router.urls
urlpatterns += entry_item_router.urls
urlpatterns += [
    # TODO: the setup route here are for first time web app setup wizard.
    # path('setup/', setupView, name="setup"),

    path('accounts/login/', auth_views.LoginView.as_view(form_class=LoginForm), name='login'),

    path('projects/', project_index, name='project-list'),
    # path('projects/create/', ProjectCreateView.as_view(), name='project-create'),
    path('projects/<int:pk>/', ProjectDetailView.as_view(), name='project-detail'),
    path('projects/<int:pk>/update/', project_update, name='project-update'),
    path('projects/<int:pk>/delete/', delete_project, name='project-delete'),

    path('account-types/', AccountTypeListView.as_view(), name='account-type-list'),
    path('account-types/create/', AccountTypeCreateView.as_view(), name='account-type-create'),
    path('account-types/<int:pk>/', AccountTypeDetailView.as_view(), name='account-type-detail'),
    path('account-types/<int:pk>/update/', AccountTypeUpdateView.as_view(), name='account-type-update'),

    path('entries/', AccountingEntryListView.as_view(), name='entry-list'),
    path('entries/create/', create_entry, name='entry-create'),
    path('entries/<int:pk>/', AccountingEntryDetailView.as_view(), name='entry-detail'),
]
