# Generated by Django 4.1 on 2022-11-20 18:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0001_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='user',
            options={'verbose_name': 'user', 'verbose_name_plural': 'users'},
        ),
        migrations.AddField(
            model_name='user',
            name='is_reset_password',
            field=models.BooleanField(default=True),
        ),
        migrations.AlterModelTable(
            name='user',
            table=None,
        ),
    ]
