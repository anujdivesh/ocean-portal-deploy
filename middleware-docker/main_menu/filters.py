import django_filters
from .models import MainMenu

class MainMenuFilter(django_filters.FilterSet):
    display_title = django_filters.CharFilter(field_name='display_title', lookup_expr='icontains')
    theme_id = django_filters.NumberFilter(field_name='theme__id')  # Use theme__id for filtering the related model's id

    class Meta:
        model = MainMenu
        fields = ['display_title', 'theme_id']  # Include theme_id for filtering on the related Theme model
