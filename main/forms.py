from django.forms import (
    Form, ValidationError, Textarea,
    CharField, FloatField, ChoiceField, BaseInlineFormSet, ModelForm
)
from django.contrib.auth.forms import AuthenticationForm
from .models import AccountingEntry, EntryItem, AccountType

from django.forms import inlineformset_factory
from django.forms.widgets import (
    CheckboxInput, NumberInput, Select
)


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
        super(EntryFormset, self).__init__(
            data, files, instance, save_as_new, prefix, queryset, **kwargs
        )

    def clean(self):
        super(EntryFormset, self).clean()

        if not float(self.debit_amount) == sum([
            form.cleaned_data['amount'] for form in self.forms
        ]):
            raise ValidationError("مبلغ المدين لا يساوي مبلغ الدائن.")


class EntryDebitItemForm(ModelForm):
    class Meta:
        model = EntryItem
        fields = ['amount', 'type']
        widgets = {
            'amount': NumberInput(attrs={'class': 'form-control', 'min': '1'}),
            'type': Select(attrs={'class': 'form-control select-box'})
        }


class EntryForm(Form):
    description = CharField(widget=Textarea(attrs={
        'class': 'form-control', 'placeholder': 'الوصف'
    }))


EntryFormSet = inlineformset_factory(
    AccountingEntry, EntryItem, formset=EntryFormset, can_delete=False, extra=1,
    fields=(
        'is_debit', 'amount', 'type', 'project'
    ),
    widgets={
        'is_debit': CheckboxInput(attrs={'class': 'd-none'}),
        'amount': NumberInput(attrs={'class': 'form-control', 'min': '1'}),
        'type': Select(attrs={'class': 'form-control select-box'}),
        'project': Select(attrs={'class': 'form-control select-box'}),
    }
)


class LoginForm(AuthenticationForm):
    def __init__(self, request=None, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].widget.attrs['class'] = "form-control"
        self.fields['password'].widget.attrs['class'] = "form-control"

# TODO: make user creation form for admin
