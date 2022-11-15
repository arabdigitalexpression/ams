from django.contrib.auth.models import User
from django.db import models


class Currency(models.Model):
    name = models.CharField(max_length=100)
    symbol = models.CharField(unique=True, max_length=3)
    code = models.CharField(unique=True, max_length=3)
    is_primary = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class AccountType(models.Model):

    class LevelEnum(models.TextChoices):
        MAIN = "M", "رئيسي"
        SUB = "S", "فرعي"

    class BalanceType(models.TextChoices):
        Debit = "D", "مدين"
        Credit = "C", "دائن"

    name = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now=True)
    is_archived = models.BooleanField(default=False)
    is_default = models.BooleanField(default=False)
    level_type = models.CharField(
        max_length=1, choices=LevelEnum.choices,
    )
    balance_type = models.CharField(
        max_length=1, choices=BalanceType.choices,
    )
    # TODO: default= filter currency code using a hardcoded Dict, Enum or Json file
    currency = models.ForeignKey(
        Currency, on_delete=models.SET_DEFAULT, related_name="accounts",
        default=1
    )
    parent_account = models.ForeignKey(
        'self', on_delete=models.SET_NULL, null=True, blank=True,
        related_name="child_account"
    )

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        from django.urls import reverse
        return reverse('account-type-detail', kwargs={'pk': self.pk})

    @property
    def children(self):
        return self.child_account.all()

    @property
    def has_children(self):
        return self.child_account.exists()

    @property
    def has_entry_items(self):
        return (
            self.debit_items.count() > 0 or
            self.credit_items.count() > 0
        )

    @property
    def is_not_empty(self):
        return not (
            self.has_entry_items or
            self.has_children or
            self.is_default
        )


class Project(models.Model):
    name = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        from django.urls import reverse
        return reverse('project-detail', kwargs={'pk': self.pk})


class AccountingEntry(models.Model):
    number = models.IntegerField(blank=False, null=False)
    total = models.FloatField()
    description = models.TextField()
    created_at = models.DateTimeField(auto_now=True)
    created_by = models.ForeignKey(
        User, on_delete=models.SET_NULL,
        blank=True, null=True, related_name="entries"
    )
    reverse_entry = models.ForeignKey(
        'self', on_delete=models.SET_NULL, null=True, blank=True
    )

    @property
    def serial_number(self):
        date = self.created_at.strftime("%d/%m/%Y")
        return f"{self.number}/{date}"

    def __str__(self):
        return f"serial: {self.serial_number}"

    def get_absolute_url(self):
        from django.urls import reverse
        return reverse('entry-detail', kwargs={'pk': self.pk})


class EntryItem(models.Model):
    exchange_rate = models.FloatField(blank=True, null=True)
    debit_amount = models.FloatField()
    debit_account = models.ForeignKey(
        AccountType, on_delete=models.SET_NULL,
        blank=True, null=True, related_name="debit_items"
    )
    credit_amount = models.FloatField()
    credit_account = models.ForeignKey(
        AccountType, on_delete=models.SET_NULL,
        blank=True, null=True, related_name="credit_items"
    )
    entry = models.ForeignKey(
        AccountingEntry, on_delete=models.PROTECT, related_name="items"
    )
    project = models.ForeignKey(
        Project, on_delete=models.SET_NULL,
        blank=True, null=True, related_name="items"
    )

    def __str__(self):
        return f"entry with ledger id: {self.entry.id}"
