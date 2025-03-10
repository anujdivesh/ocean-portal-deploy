# Generated by Django 4.2.16 on 2025-01-15 20:44

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("theme", "0001_initial"),
        ("main_menu", "0003_alter_mainmenu_options"),
    ]

    operations = [
        migrations.AddField(
            model_name="mainmenu",
            name="theme",
            field=models.ForeignKey(
                default=1,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="theme_id",
                to="theme.theme",
            ),
            preserve_default=False,
        ),
    ]
