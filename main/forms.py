from django.forms import (
    ModelForm, TextInput, Select, Textarea
)
from .models import AccountingEntry, EntryItem

from django.forms import inlineformset_factory
EntryFormSet = inlineformset_factory(
    AccountingEntry, EntryItem, can_delete=False, extra=1,
    fields=(
        'is_debit', 'amount', 'type', 'project'
    ))

class EntryForm(ModelForm):


    class Meta:
        model = AccountingEntry
        fields = ('description', 'items_set')

    widgets = {
        'description': Textarea(attrs={'class': 'form-control'}),
        'items_set': Select(attrs={'class': 'form-control'}),
    }
