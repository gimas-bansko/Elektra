from django.contrib import admin
from .models import *

from django.contrib import messages
from .document_generator import generate_test_and_key


admin.site.register(UserProfile)

# Персонализиран филтър за Specialty
class SpecialtyFilter(admin.SimpleListFilter):
    title = 'Специалност'  # Име на филтъра в админ панела
    parameter_name = 'specialty'  # Параметърът, който ще се използва в заявката

    def lookups(self, request, model_admin):
        # Връща списък от специалности за филтриране
        specialties = Specialty.objects.all()
        return [(specialty.id, str(specialty)) for specialty in specialties]

    def queryset(self, request, queryset):
        # Филтрира ThemeItem по специалност
        if self.value():
            return queryset.filter(theme_id__specialty__id=self.value())
        return queryset

# Регистрация на Theme
@admin.register(Theme)
class ThemeV(admin.ModelAdmin):
    list_display = ('num', 'title', 'specialty', 'tasks_total', 'tasks_knowledge', 'tasks_comprehension', 'tasks_application', 'tasks_analysis')
    list_display_links = ('num', 'title', )
    list_filter = ('specialty', )
    ordering = ('num', )

# Регистрация на ThemeItem
@admin.register(ThemeItem)
class ThemeItemV(admin.ModelAdmin):
    list_display = ('item', 'title', 'total_points', 'knowledge', 'comprehension', 'application', 'analysis')
    list_display_links = ('title', )
    list_filter = (SpecialtyFilter, 'theme_id',)  # Добавяме персонализирания филтър
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


@admin.register(GeneratedTest)
class GeneratedTestAdmin(admin.ModelAdmin):
    list_display = ('topic', 'school', 'generation_date')
    list_filter = ('topic', 'school')
    actions = ['regenerate_documents']

    def regenerate_documents(self, request, queryset):
        success_count = 0
        for gen_test in queryset:
            try:
                generate_test_and_key(gen_test.topic.id, gen_test.school.id)
                success_count += 1
            except Exception as e:
                self.message_user(
                    request,
                    f'Грешка при регенериране на тест за {gen_test}: {e}',
                    messages.ERROR
                )

        if success_count:
            self.message_user(
                request,
                f'Успешно регенерирани {success_count} теста',
                messages.SUCCESS
            )

    regenerate_documents.short_description = "Регенерирай избраните тестове"
