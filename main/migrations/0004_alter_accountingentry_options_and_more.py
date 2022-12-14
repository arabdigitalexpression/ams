# Generated by Django 4.1 on 2022-12-14 13:58

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0003_auto_20221207_1023'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='accountingentry',
            options={'default_permissions': [], 'permissions': [('add_accountingentry', 'إضافة قيد'), ('view_accountingentry', 'عرض بيانات قيد')]},
        ),
        migrations.AlterModelOptions(
            name='accounttype',
            options={'default_permissions': [], 'permissions': [('add_accounttype', 'إضافة حساب'), ('change_accounttype', 'تغيير بيانات حساب'), ('delete_accounttype', 'حذف حساب'), ('view_accounttype', 'عرض بيانات حساب')]},
        ),
        migrations.AlterModelOptions(
            name='currency',
            options={'default_permissions': [], 'permissions': [('add_currency', 'إضافة عملة'), ('change_currency', 'تغيير بيانات عملة'), ('delete_currency', 'حذف عملة'), ('view_currency', 'عرض بيانات عملة')]},
        ),
        migrations.AlterModelOptions(
            name='entryitem',
            options={'default_permissions': [], 'permissions': [('add_entryitem', 'إضافة بند'), ('view_entryitem', 'عرض بيانات بند')]},
        ),
        migrations.AlterModelOptions(
            name='project',
            options={'default_permissions': [], 'permissions': [('add_project', 'إضافة مشروع'), ('change_project', 'تغيير بيانات مشروع'), ('delete_project', 'حذف مشروع'), ('view_project', 'عرض بيانات مشروع')]},
        ),
        migrations.AlterModelOptions(
            name='user',
            options={'default_permissions': [], 'permissions': [('add_user', 'إضافة مستخدم'), ('change_user', 'تغيير بيانات مستخدم'), ('delete_user', 'حذف مستخدم'), ('view_user', 'عرض بيانات مستخدم')]},
        ),
        migrations.AlterField(
            model_name='entryitem',
            name='project',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='items', to='main.project'),
        ),
    ]