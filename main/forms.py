from django.contrib.auth.forms import (
    AuthenticationForm, PasswordChangeForm as PCF,
    SetPasswordForm as SPF, UsernameField
)
from django.contrib.auth.models import Group, Permission
from django.db.models import Q

from django.forms import (
    Form, ModelForm, ValidationError, TextInput,
    CharField, BaseInlineFormSet, ChoiceField,
    DateField, DateInput
)
from django.forms import inlineformset_factory
from django.forms.widgets import (
    Textarea, NumberInput, CheckboxSelectMultiple,
    Select, EmailInput, HiddenInput
)

from .models import (
    AccountingEntry, EntryItem, Project,
    AccountType, User
)


class EntryFormset(BaseInlineFormSet):

    def __init__(self, *args, **kwargs):
        self.debit_amount = kwargs.pop('debit_amount')
        self.debit_account = kwargs.pop('debit_account')
        super(EntryFormset, self).__init__(*args, **kwargs)

    def clean(self):
        super(EntryFormset, self).clean()

        if not float(self.debit_amount) == sum([
            form.cleaned_data['credit_amount'] for form in self.forms
        ]):
            raise ValidationError("مبلغ المدين لا يساوي مبلغ الدائن.")
        debit_account_id = int(self.debit_account)
        if any([
            form.cleaned_data['credit_account'].id == debit_account_id
            for form in self.forms
        ]):
            raise ValidationError(
                "استخدام حساب المدين في بنود الدائن غير مسموح"
            )


class EntryDebitItemForm(ModelForm):
    class Meta:
        model = EntryItem
        fields = ['debit_amount', 'debit_account']
        widgets = {
            'debit_amount': NumberInput(attrs={'class': 'form-control border', 'min': '1'}),
            'debit_account': Select(attrs={'class': 'form-select border'})
        }

    def __init__(self, *args, **kwargs):
        super(EntryDebitItemForm, self).__init__(*args, **kwargs)
        self.fields['debit_account'].queryset = AccountType.objects.filter(
            level_type=AccountType.LevelEnum.SUB.value
        )


class EntryCreditItemForm(ModelForm):
    class Meta:
        model = EntryItem
        fields = ['credit_amount', 'credit_account', 'project']
        widgets = {
            'credit_amount': NumberInput(
                attrs={'class': 'form-control border', 'min': '1'}
            ),
            'credit_account': Select(
                attrs={'class': 'form-select border'}
            ),
            'project': Select(
                attrs={'class': 'form-select border'}
            ),
        }

    def __init__(self, *args, **kwargs):
        super(EntryCreditItemForm, self).__init__(*args, **kwargs)
        self.fields['credit_account'].queryset = AccountType.objects.filter(
            level_type=AccountType.LevelEnum.SUB.value
        )


class EntryForm(Form):
    description = CharField(widget=Textarea(attrs={
        'class': 'form-control border w-100 pe-2', 'placeholder': 'البيان'
    }))


EntryFormSet = inlineformset_factory(
    AccountingEntry, EntryItem, form=EntryCreditItemForm,
    formset=EntryFormset, can_delete=False, extra=1,
    fields=(
        'credit_amount', 'credit_account', 'project'
    ),
)


class LoginForm(AuthenticationForm):
    def __init__(self, request=None, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].widget.attrs['class'] = "form-control"
        self.fields['username'].widget.attrs['placeholder'] = "اسم المستخدم"
        self.fields['password'].widget.attrs['class'] = "form-control"
        self.fields['password'].widget.attrs['placeholder'] = "كلمة المرور"


class SetPasswordForm(SPF):

    def __init__(self, user, *args, **kwargs):
        super(SetPasswordForm, self).__init__(user, *args, **kwargs)
        self.fields['new_password1'].widget.attrs['class'] = "form-control"
        self.fields['new_password1'].widget.attrs['placeholder'] = "كلمة المرور الجديدة"
        self.fields['new_password2'].widget.attrs['class'] = "form-control"
        self.fields['new_password2'].widget.attrs['placeholder'] = "تأكيد كلمة المرور الجديدة"

    def save(self, commit=True):
        password = self.cleaned_data["new_password1"]
        self.user.set_password(password)
        self.user.is_reset_password = False
        if commit:
            self.user.save()
        return self.user


class PasswordChangeForm(PCF):
    def __init__(self, request=None, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['old_password'].widget.attrs['class'] = "form-control border pe-2 mb-3 "
        self.fields['old_password'].widget.attrs['placeholder'] = "كلمة المرور الحالية"
        self.fields['new_password1'].widget.attrs['class'] = "form-control border pe-2 mb-3"
        self.fields['new_password1'].widget.attrs['placeholder'] = "كلمة المرور الجديدة"
        self.fields['new_password2'].widget.attrs['class'] = "form-control border pe-2 mb-3"
        self.fields['new_password2'].widget.attrs['placeholder'] = "تأكيد كلمة المرور الجديدة"


# TODO: make user creation form for admin


class ProjectForm(ModelForm):
    class Meta:
        model = Project
        fields = ["name"]
        widgets = {
            "name": TextInput(attrs={"class": "form-control w-25 border pe-2", "placeholder": "أسم المشروع"}),
        }


class AccountCreateForm(ModelForm):
    class Meta:
        model = AccountType
        fields = [
            "name", "level_type", "balance_type",
            "currency", "parent_account"
        ]
        widgets = {
            "name": TextInput(attrs={
                "class": "form-control border pe-2", "placeholder": "أسم الحساب"
            }),
            "level_type": Select(attrs={
                "class": "form-control border pe-2",
            }),
            "balance_type": Select(attrs={
                "class": "form-control border pe-2",
            }),
            "currency": Select(attrs={
                "class": "form-control border pe-2",
            }),
            "parent_account": Select(attrs={
                "class": "form-control border pe-2",
            }),
        }

    def clean(self):
        super(AccountCreateForm, self).clean()

        level = self.cleaned_data['parent_account'].level_type
        if AccountType.LevelEnum(level).SUB == level:
            raise ValidationError("برجاء عدم اختيار حساب تحت حساب فرعي اخر.")


class AccountUpdateForm(ModelForm):
    class Meta:
        model = AccountType
        fields = [
            "name", "balance_type",
            "currency", "parent_account"
        ]
        widgets = {
            "name": TextInput(attrs={
                "class": "form-control border pe-2", "placeholder": "أسم الحساب"
            }),
            "balance_type": Select(attrs={
                "class": "form-control border pe-2",
            }),
            "currency": Select(attrs={
                "class": "form-control border pe-2",
            }),
            "parent_account": Select(attrs={
                "class": "form-control border pe-2",
            }),
        }

    def clean(self):
        super(AccountUpdateForm, self).clean()

        level = self.cleaned_data['parent_account'].level_type
        if AccountType.LevelEnum(level).SUB == level:
            raise ValidationError("برجاء عدم اختيار حساب تحت حساب فرعي اخر.")


class UserForm(ModelForm):
    class Meta:
        model = User
        fields = [
            "first_name", "last_name", "email",
            "username", "groups",
        ]
        widgets = {
            "first_name": TextInput(attrs={
                "class": "form-control border pe-2",
                "placeholder": "الأسم الأول"
            }),
            "last_name": TextInput(attrs={
                "class": "form-control border pe-2",
                "placeholder": "الأسم الأخير"
            }),
            "email": EmailInput(attrs={
                "class": "form-control border pe-2",
                "placeholder": "البريد الإلكتروني"
            }),
            "username": TextInput(attrs={
                "class": "form-control border pe-2",
                "placeholder": "أسم المستخدم"
            }),
            "groups": CheckboxSelectMultiple(
            )
        }


class GroupPermissionForm(ModelForm):
    class Meta:
        model = Group
        fields = [
            "name", "permissions",
        ]
        widgets = {
            "name": TextInput(attrs={
                "class": "form-control border pe-2",
                "placeholder": "أسم المجوعة"
            }),
            "permissions": CheckboxSelectMultiple(attrs={
                "class": "border pe-2"
            }),
        }

    def __init__(self, user=None, **kwargs):
        super(GroupPermissionForm, self).__init__(**kwargs)
        self.fields['permissions'].choices = [
            (perm.id, perm.name)
            for perm in Permission.objects.exclude(
                Q(content_type__app_label="admin") |
                Q(content_type__app_label="auth") |
                Q(content_type__app_label="contenttypes") |
                Q(content_type__app_label="sessions") |
                Q(codename="change_entryitem") |
                Q(codename="delete_entryitem") |
                Q(codename="change_accountingentry") |
                Q(codename="delete_accountingentry")
            ).all()
        ]


class LedgerFilterForm(Form):
    from_date = DateField(required=False, widget=DateInput(attrs={
        "type": "date", "class": "form-control border pe-2 mb-3 ",
        "placeholder": "من تاريخ"
    }))
    to_date = DateField(required=False, widget=DateInput(attrs={
        "type": "date", "class": "form-control border pe-2 mb-3 ",
        "placeholder": "إلى تاريخ"
    }))
    project = ChoiceField(
        required=False,
        choices=[("", "--- اختر مشروع ---")] + [
            (project.id, project.name)
            for project in Project.objects.all()
        ],
        widget=Select(
            attrs={
                "class": "form-control border pe-2 mb-3"
            }
        )
    )
    account = ChoiceField(
        required=False,
        choices=[("", "--- اختر حساب ---")] + [
            (account_type.id, account_type.name)
            for account_type in AccountType.objects
            .filter(level_type=AccountType.LevelEnum.SUB.value).all()
        ],
        widget=Select(
            attrs={
                "class": "form-control border pe-2 mb-3"
            }
        )
    )

    def clean(self):
        super(LedgerFilterForm, self).clean()

        account = self.cleaned_data['account']
        if not account:
            raise ValidationError("برجاء إختيار نوع حساب علي الأقل.")


class TrialBalanceFilterForm(Form):
    from_date = DateField(required=False, widget=DateInput(attrs={
        "type": "date", "class": "form-control border pe-2 mb-3 ",
        "placeholder": "من تاريخ"
    }))
    to_date = DateField(required=False, widget=DateInput(attrs={
        "type": "date", "class": "form-control border pe-2 mb-3 ",
        "placeholder": "إلى تاريخ"
    }))
