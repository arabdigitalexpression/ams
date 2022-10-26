from django.contrib.auth.models import User
from django.db import models


# Create your models here.
class AccountType(models.Model):
    name = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        from django.urls import reverse
        return reverse('account-type-detail', kwargs={'pk': self.pk})


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
    created_by = models.ForeignKey(User, on_delete=models.SET_NULL, blank=True, null=True)
    reverse_entry = models.ForeignKey('self', on_delete=models.SET_NULL, null=True, blank=True)

    @property
    def serial_number(self):
        date = self.created_at.strftime("%d/%m/%Y")
        return f"{self.number}/{date}"

    def __str__(self):
        return f"serial: {self.serial_number}"

    def get_absolute_url(self):
        from django.urls import reverse
        return reverse('entry-detail', kwargs={'pk': self.pk})


class Label(models.Model):
    name = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class EntryItem(models.Model):
    is_debit = models.BooleanField()
    amount = models.FloatField()
    type = models.ForeignKey(
        AccountType, on_delete=models.SET_NULL, blank=True, null=True
    )
    entry = models.ForeignKey(
        AccountingEntry, on_delete=models.PROTECT, related_name="items"
    )
    label = models.ForeignKey(
        Label, on_delete=models.SET_NULL, blank=True, null=True
    )
    project = models.ForeignKey(
        Project, on_delete=models.SET_NULL, blank=True, null=True
    )

    def __str__(self):
        return f"entry with type {self.type.name} and ledger id: {self.entry.id}"
