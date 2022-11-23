from django.urls import path
from django.contrib.auth import views as auth_views
from django.shortcuts import reverse
from rest_framework.routers import DefaultRouter

from .forms import LoginForm, PasswordChangeForm
from .views import (
    UserViewSet, ProjectViewSet, AccountTypeViewSet,
    AccountingEntryViewSet, EntryItemViewSet,

    ProjectDetailView, project_index,
    project_update, delete_project,

    AccountingEntryListView, AccountingEntryDetailView,
    create_entry,

    account_create, account_list, account_detail,
    account_update, delete_account,

    UserListView, user_detail,
    user_update, delete_user, user_create,

    set_password_page, reset_user_password,
    user_profile, list_group, create_group,
    update_group,

    # setupView
)

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

    path('auth/login/', auth_views.LoginView.as_view(
        form_class=LoginForm,
    ), name='login'),
    path('auth/logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('auth/change-password/', auth_views.PasswordChangeView.as_view(
        template_name="main/user/password_change_form.html",
        form_class=PasswordChangeForm, success_url="/"
    ), name='logout'),
    path('auth/set-password', set_password_page, name="set-password"),

    path('projects/', project_index, name='project-list'),
    # path('projects/create/', ProjectCreateView.as_view(), name='project-create'),
    path('projects/<int:pk>/', ProjectDetailView.as_view(), name='project-detail'),
    path('projects/<int:pk>/update/', project_update, name='project-update'),
    path('projects/<int:pk>/delete/', delete_project, name='project-delete'),

    path('account-types/', account_list, name='account-type-list'),
    path('account-types/create/', account_create, name='account-type-create'),
    path('account-types/<int:pk>/', account_detail, name='account-type-detail'),
    path('account-types/<int:pk>/update/', account_update, name='account-type-update'),
    path('account-types/<int:pk>/delete/', delete_account, name='account-type-delete'),

    path('entries/', AccountingEntryListView.as_view(), name='entry-list'),
    path('entries/create/', create_entry, name='entry-create'),
    path('entries/<int:pk>/', AccountingEntryDetailView.as_view(), name='entry-detail'),

    path('auth/profile/', user_profile, name='user-profile'),
    path('auth/users/', UserListView.as_view(), name='user-list'),
    path('auth/users/create/', user_create, name='user-create'),
    path('auth/users/<int:pk>/', user_detail, name='user-detail'),
    path('auth/users/<int:pk>/update/', user_update, name='user-update'),
    path('auth/users/<int:pk>/delete/', delete_user, name='user-delete'),
    path('auth/users/<int:pk>/reset-password/', reset_user_password, name='user-reset-password'),

    path('auth/groups/', list_group, name='group-list'),
    path('auth/groups/create/', create_group, name='group-create'),
    path('auth/groups/<int:pk>/update/', update_group, name='group-update'),
]
