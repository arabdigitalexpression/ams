from django.contrib.auth.forms import AuthenticationForm
from django.forms import (
    Form, ValidationError, Textarea, TextInput,
    CharField, BaseInlineFormSet, ModelForm
)
from django.forms import inlineformset_factory
from django.forms.widgets import (
    NumberInput, Select
)

from .models import AccountingEntry, EntryItem, Project


class EntryFormset(BaseInlineFormSet):

    def __init__(
            self,
            data=None,
            files=None,
            instance=None,
            save_as_new=False,
            prefix=None,
            queryset=None,
            **kwargs,
    ):
        self.debit_amount = kwargs.pop('debit_amount')
        self.debit_account = kwargs.pop('debit_account')
        super(EntryFormset, self).__init__(
            data, files, instance, save_as_new, prefix, queryset, **kwargs
        )

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
            'debit_amount': NumberInput(attrs={'class': 'form-control', 'min': '1'}),
            'debit_account': Select(attrs={'class': 'form-control select-box'})
        }


class EntryForm(Form):
    description = CharField(widget=Textarea(attrs={
        'class': 'form-control', 'placeholder': 'الوصف'
    }))


EntryFormSet = inlineformset_factory(
    AccountingEntry, EntryItem, formset=EntryFormset, can_delete=False, extra=1,
    fields=(
        'credit_amount', 'credit_account', 'project'
    ),
    widgets={
        'credit_amount': NumberInput(attrs={'class': 'form-control', 'min': '1'}),
        'credit_account': Select(attrs={'class': 'form-control select-box'}),
        'project': Select(attrs={'class': 'form-control select-box'}),
    }
)


class LoginForm(AuthenticationForm):
    def __init__(self, request=None, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].widget.attrs['class'] = "form-control"
        self.fields['username'].widget.attrs['placeholder'] = "اسم المستخدم"
        self.fields['password'].widget.attrs['class'] = "form-control"
        self.fields['password'].widget.attrs['placeholder'] = "كلمة المرور"


# TODO: make user creation form for admin


class ProjectForm(ModelForm):
    class Meta:
        model = Project
        fields = ["name"]
        widgets = {
            "name": TextInput(attrs={"class": "form-control w-25 border pe-1", "placeholder": "أسم المشروع"}),
        }
