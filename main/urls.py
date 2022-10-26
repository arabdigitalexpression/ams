from django.urls import path
from django.contrib.auth import views as auth_views
from rest_framework.routers import DefaultRouter
from .views import (
    UserViewSet, ProjectViewSet, LabelViewSet, AccountTypeViewSet,
    AccountingEntryViewSet, EntryItemViewSet, ProjectDetailView,
    ProjectListView, ProjectCreateView, ProjectUpdateView,
    AccountTypeListView, AccountTypeDetailView,
    AccountTypeUpdateView, AccountTypeCreateView,
    AccountingEntryCreateView, AccountingEntryListView,
    AccountingEntryDetailView,
    # setupView
)

user_router = DefaultRouter()
user_router.register(r'api/users', UserViewSet, basename='user')

project_router = DefaultRouter()
project_router.register(r'api/projects', ProjectViewSet, basename='project')

label_router = DefaultRouter()
label_router.register(r'api/labels', LabelViewSet, basename='label')

account_type_router = DefaultRouter()
account_type_router.register(r'api/account-types', AccountTypeViewSet, basename='accounttype')

entry_router = DefaultRouter()
entry_router.register(r'api/entries', AccountingEntryViewSet, basename='accountingentry')

entry_item_router = DefaultRouter()
entry_item_router.register(r'api/entry-items', EntryItemViewSet, basename='entryitem')


urlpatterns = user_router.urls
urlpatterns += project_router.urls
urlpatterns += label_router.urls
urlpatterns += account_type_router.urls
urlpatterns += entry_router.urls
urlpatterns += entry_item_router.urls
urlpatterns += [
    # TODO: the setup route here are for first time web app setup wizard.
    # path('setup/', setupView, name="setup"),

    path('accounts/login/', auth_views.LoginView.as_view(), name='login'),

    path('projects/', ProjectListView.as_view(), name='project-list'),
    path('projects/create/', ProjectCreateView.as_view(), name='project-create'),
    path('projects/<int:pk>/', ProjectDetailView.as_view(), name='project-detail'),
    path('projects/<int:pk>/update/', ProjectUpdateView.as_view(), name='project-update'),

    path('account-types/', AccountTypeListView.as_view(), name='account-type-list'),
    path('account-types/create/', AccountTypeCreateView.as_view(), name='account-type-create'),
    path('account-types/<int:pk>/', AccountTypeDetailView.as_view(), name='account-type-detail'),
    path('account-types/<int:pk>/update/', AccountTypeUpdateView.as_view(), name='account-type-update'),

    path('entries/', AccountingEntryListView.as_view(), name='entry-list'),
    path('entries/create/', AccountingEntryCreateView.as_view(), name='entry-create'),
    path('entries/<int:pk>/', AccountingEntryDetailView.as_view(), name='entry-detail'),
]
