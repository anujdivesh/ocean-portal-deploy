from django.http import HttpResponse
from django.template import loader
from django.shortcuts import render  
from rest_framework.views import APIView  
from rest_framework.response import Response  
from rest_framework import status  
from django.shortcuts import get_object_or_404
from task_download.models import TaskDownload
from datetime import datetime
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

def nav(request):
    items = [
        {'title': 'Wavewatch 3 forecast', 'content': 'Content for the first accordion item.'},
        {'title': 'Salinity Forecast', 'content': 'Content for the second accordion item.'},
        {'title': 'PH Forecast', 'content': 'Content for the third accordion item.'},
        
    ]
    return render(request, 'navbar.html', {'items': items})

def data(request):
    current_time = datetime.now()
    emplist = TaskDownload.objects.all().order_by('id')
    page = request.GET.get('page', 1)
  
    paginator = Paginator(emplist, 20)
    try:
        employees = paginator.page(page)
    except PageNotAnInteger:
        employees = paginator.page(1)
    except EmptyPage:
        employees = paginator.page(paginator.num_pages)
    
    return render(request, 'data.html', { 'employees': employees,'current_time':current_time })

def products(request):
    return render(request, 'products.html')


def api(request):
    return render(request, 'api.html')


def database(request):
    return render(request, 'database.html')


def server(request):
    return render(request, 'server.html')

