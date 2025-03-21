from django.contrib import admin
from .models import *

admin.site.register(UserProfile)

admin.site.register(Theme)

@admin.register(ThemeItem)
class ThemeItemV(admin.ModelAdmin):
    list_display = ('item', 'title', 'total_points', 'knowledge', 'comprehension', 'application', 'analysis')
    list_display_links = ('title', )
    list_filter = ('theme_id', )
    ordering = ('item', )

admin.site.register(Task)
admin.site.register(TaskItem)
admin.site.register(School)
admin.site.register(Specialty)
admin.site.register(Documents)
admin.site.register(Remark)
admin.site.register(TaskContext)

@admin.register(Log)
class LogV(admin.ModelAdmin):
    list_display = ('user_name', 'action', 'date' )
    list_display_links = ('user_name', 'action', )
    list_filter = ('user_name', 'action', )
    ordering = ('-date', )

