"""
URL configuration for pop_middleware project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include, path
from datasets.views import datasets
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from . import views

admin.site.site_header = "Ocean Portal Admin"
admin.site.site_title = "Ocean Portal Middleware Portal"
admin.site.index_title = "Welcome to Ocean Portal Middleware"

admin.site.site_url = '/middleware'  # Removes the 'View Site' link
admin.site.site_header = 'Monitoring | Home'

urlpatterns = [
    #DISPLAY PAGES
    path('middleware', views.data, name='homepage2'),
    path('middleware/', views.data, name='homepage3'),
    path('middleware/data', views.data, name='data'),
    path('middleware/products', views.products, name='products'),
    path('middleware/api', views.api, name='api'),
    path('middleware/database', views.database, name='database'),
    path('middleware/server', views.server, name='server'),

    #ADMIN
    path("middleware/admin/", admin.site.urls),

    #APIS
    path('middleware/api/', include('datasets.urls')),
    path('middleware/api/', include('task_download.urls')),
    path('middleware/api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('middleware/api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),  
    path('middleware/api/', include('country.urls')),
    path('middleware/api/', include('data_type.urls')),
    path('middleware/api/', include('download_method.urls')),
    path('middleware/api/', include('webapp_product.urls')),
    path('middleware/api/', include('layer_web_map.urls')),
    path('middleware/api/', include('main_menu.urls')),
    path('middleware/api/', include('theme.urls')),
    path('middleware/api/', include('plotter.urls')),
]
