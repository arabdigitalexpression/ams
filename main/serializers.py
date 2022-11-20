from main.models import User
from rest_framework import serializers
from rest_framework.fields import FloatField
from rest_framework.relations import HyperlinkedIdentityField, HyperlinkedRelatedField

from .models import (
    AccountingEntry, Project, AccountType, EntryItem,
)


class UserSerializer(serializers.ModelSerializer):
    url = HyperlinkedIdentityField(view_name='user-detail')

    class Meta:
        model = User
        fields = ['url', 'id', 'username', 'email']


class EntryItemSerializer(serializers.ModelSerializer):
    url = HyperlinkedIdentityField(view_name='entryitem-detail')
    entry = HyperlinkedRelatedField(
        queryset=AccountingEntry.objects.all(),
        view_name='accountingentry-detail', required=False
    )

    class Meta:
        model = EntryItem
        fields = [
            # TODO: remove url of items
            'url', 'id', 'is_debit', 'amount', 'type',  # TODO: repr name of label, project and type
            'entry', 'label', 'project',  # TODO: remove entry when this serializer used in AccountingEntrySerializer
        ]


class AccountingEntrySerializer(serializers.ModelSerializer):
    url = HyperlinkedIdentityField(
        view_name='accountingentry-detail', required=False
    )
    items = EntryItemSerializer(many=True, read_only=False)
    total = FloatField(required=False)

    # TODO: that there's no other entry with same serial_number
    # TODO: add validation on debit & credit amounts are equal

    class Meta:
        model = AccountingEntry
        fields = [
            'url', 'id', 'number', 'serial_number', 'reverse_entry',   # TODO: reverse_entry repr as entry serial_number
            'description', 'created_at', 'total', 'created_by',  # TODO: created_by is required here? repr as username
            'items'
        ]

    def create(self, validated_data):
        valid_items = validated_data.pop('items', [])
        user = None
        request = self.context.get("request")
        if request and hasattr(request, "user"):
            user = request.user
        total = sum([
            item.get("amount", float()) for item in valid_items
        ])
        entry = AccountingEntry.objects.create(
            **validated_data, created_by=user, total=total
        )
        for item in valid_items:
            EntryItem.objects.create(**item, entry=entry)
        return entry


class ProjectSerializer(serializers.ModelSerializer):
    url = HyperlinkedIdentityField(view_name='project-detail', required=False)

    class Meta:
        model = Project
        fields = ['url', 'id', 'name', 'created_at']


class AccountTypeSerializer(serializers.ModelSerializer):
    url = HyperlinkedIdentityField(view_name='accounttype-detail', required=False)

    class Meta:
        model = AccountType
        fields = ['url', 'id', 'name', 'created_at']
