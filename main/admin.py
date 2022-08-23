from django.contrib import admin
from main.models import (
    Label, Ledger, Entry, Project, AccountType
)


# Register your models here.
@admin.register(Label)
class LabelAdmin(admin.ModelAdmin):
    search_fields = ("name", )


@admin.register(Ledger)
class LedgerAdmin(admin.ModelAdmin):
    search_fields = ("serial_number", "id")


@admin.register(Entry)
class EntryAdmin(admin.ModelAdmin):
    display_fields = ("",)
    search_fields = ("id", "is_debit")


admin.site.register(Project)
admin.site.register(AccountType)
