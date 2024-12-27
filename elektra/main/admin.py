from django.contrib import admin
from .models import *

admin.site.register(UserProfile)

admin.site.register(Theme)

@admin.register(ThemeItem)
class ThemeItemV(admin.ModelAdmin):
    list_display = ('item', 'title', )
    list_display_links = ('title', )
    list_filter = ('theme_id', )
    ordering = ('item', )
