from django.contrib import admin
from .models import TaskDownload
# Register your models here.


class TaskDownloadAdmin(admin.ModelAdmin):
    list_display = ("id","task_name", "class_id", "status","next_run_time","next_download_file",)

admin.site.register(TaskDownload,TaskDownloadAdmin)
