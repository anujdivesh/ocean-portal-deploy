from django.contrib import admin
from .models import Country
# Register your models here.


class CountryAdmin(admin.ModelAdmin):
    list_display = ("id","short_name", "long_name", "crs",)

admin.site.register(Country,CountryAdmin)
