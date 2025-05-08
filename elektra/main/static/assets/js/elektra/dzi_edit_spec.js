const App = {
    delimiters: ['[[', ']]'], // Променяме синтаксиса на [[ ]]
    data() {
        return {
            listOfSpecialties: [],
            user:{},
            school:{},
            specialty: {
                "id": 2,
                "professional_field_num": "481",
                "professional_field_name": "Компютърни науки",
                "profession_num": "481020",
                "profession_name": "Системен програмист",
                "specialty_num": "4810201",
                "specialty_name": "Системно програмиране",
                "nip": "http://127.0.0.1:8008/media_files/docs/nip_4810201.pdf",
                "level": 3,
            },

            // Списък с теми за текущата специалност
            themes: [],

            // Текуща избрана тема
            selectedTheme: null,

            // Данни за нова тема
            newTheme: {
                num: '',
                title: '',
                tasks_knowledge: 0,
                tasks_comprehension: 0,
                tasks_application: 0,
                tasks_analysis: 0
            },

            // Данни за нова подточка
            newThemeItem: {
                item: '',
                title: '',
                total_points: 20,
                knowledge: 0,
                comprehension: 0,
                application: 0,
                analysis: 0
            },

            // Състояния
            isLoading: false,
            isCreatingTheme: false,
            isCreatingThemeItem: false,
            isEditingTheme: false,
            isEditingThemeItem: false,
            selectedFile: null,
            isSaving: false,
            activeTab:0,

            // Данни за редактиране
            editingTheme: null,
            editingThemeItem: null,

            // Съобщения
            error: null,
            success: null
        }
    },
    computed: {
        pictureFileName() {
            if (this.school.logo) {
                // Извличаме името на файла от URL
                return this.school.logo.split('/').pop(); // Взема последната част от пътя
            }
            return null; // Ако няма картинка
        },
        // Проверка дали сумата от задачите съвпада с общия брой
        isThemeValid() {
            if (this.isCreatingTheme) {
                const total = parseInt(this.newTheme.tasks_knowledge) +
                    parseInt(this.newTheme.tasks_comprehension) +
                    parseInt(this.newTheme.tasks_application) +
                    parseInt(this.newTheme.tasks_analysis);
                return total === 24; // Ако общият брой трябва да е 24
            }
            return true;
        },

        // Проверка дали сумата от точките съвпада с общия брой
        isThemeItemValid() {
            if (this.isCreatingThemeItem) {
                const total = parseInt(this.newThemeItem.knowledge) +
                    parseInt(this.newThemeItem.comprehension) +
                    parseInt(this.newThemeItem.application) +
                    parseInt(this.newThemeItem.analysis);
                return total === parseInt(this.newThemeItem.total_points);
            }
            return true;
        }
    },
    methods: {
        loadUserDetails(){
            const vm = this;
            axios.get('/api/context/')
                .then(function(response){
                    vm.user = response.data
                })
        },

        sendLogRecord(txt){
            const vm=this
            axios({
                method:'POST',
                url:'/api/SaveLogRecord/',
                headers:{
                    'X-CSRFToken':CSRF_TOKEN,
                    //'Access-Control-Allow-Origin':'*',
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
                data:{
                    action: txt,
                }
            })
        },
        editSpecialty() {
            // Записваме действието в лога
            this.sendLogRecord(`Започване на редактиране на специалност с ID ${specialtyId}`);
            console.log(`Започване на редактиране на специалност с ID ${specialtyId}`);

            // Пренасочване
            window.location.href = `/edit_spec/${specialtyId}`;
        },
        loadSpecialty() {
            const vm = this;
            axios.get('/api/specialty/'+SPEC+'/')
                .then(function(response){
                    vm.specialty = response.data
                })
        },

        getFileName(path) {
            // Извлича името на файла от пълния път
            if (!path) return '';
            return path.split('/').pop();
        },
        handleFileUpload(event) {
            this.selectedFile = event.target.files[0];
        },
        uploadNipFile() {
            if (!this.selectedFile) return;

            const formData = new FormData();
            formData.append('nip', this.selectedFile);

            const vm = this;
            axios.post('/api/specialty/' + SPEC + '/upload_nip/', formData, {
                headers: {'X-CSRFToken':CSRF_TOKEN, 'Content-Type': 'multipart/form-data'},
            })
                .then(function(response) {
                    // Актуализираме специалността с новия път към файла
                    vm.specialty.nip = response.data.nip;
                    vm.selectedFile = null;
                    alert("Файлът е качен успешно!");
                })
                .catch(function(error) {
                    console.error("Грешка при качване на файл:", error);
                    alert("Възникна грешка при качване на файла.");
                });
        },
        saveSpecialty() {
            const vm = this;
            vm.isSaving = true;

            // Изпращане на PUT заявка към API
            axios.put('/api/specialty/'+SPEC+'/', this.specialty, {
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': CSRF_TOKEN
                }
            })
                .then(function(response) {
                    vm.isSaving = false;
                    // Актуализиране на локалните данни (ако е необходимо)
                    vm.specialty = response.data;
                    // Показване на съобщение за успех
                    alert("Данните са записани успешно!");
                })
                .catch(function(error) {
                    vm.isSaving = false;
                    console.error("Грешка при запазване на данни:", error);
                    alert("Възникна грешка при запазване на данните!");
                });
        },

        // Зареждане на теми и техните подточки за текущата специалност
        loadThemes() {
            const vm = this;
            vm.isLoading = true;
            vm.error = null;

            axios.get('/api/specialty/' + SPEC + '/themes/')
                .then(function(response) {
                    vm.themes = response.data;
                    vm.isLoading = false;
                })
                .catch(function(error) {
                    console.error("Грешка при зареждане на теми:", error);
                    vm.error = "Възникна грешка при зареждане на темите.";
                    vm.isLoading = false;
                });
        },

        // Избиране на тема за преглед/редактиране
        selectTheme(theme) {
            this.selectedTheme = theme;
            this.clearMessages();
        },

        // Показване на форма за нова тема
        showCreateThemeForm() {
            this.newTheme = {
                num: '',
                title: '',
                tasks_knowledge: 0,
                tasks_comprehension: 0,
                tasks_application: 0,
                tasks_analysis: 0
            };
            this.isCreatingTheme = true;
            this.isEditingTheme = false;
            this.clearMessages();
        },

        // Показване на форма за нова подточка
        showCreateThemeItemForm(theme) {
            this.newThemeItem = {
                item: '',
                title: '',
                total_points: 20,
                knowledge: 0,
                comprehension: 0,
                application: 0,
                analysis: 0
            };
            this.isCreatingThemeItem = true;
            this.isEditingThemeItem = false;
            this.selectedTheme = theme;
            this.clearMessages();
        },

        // Показване на форма за редактиране на тема
        showEditThemeForm(theme) {
            this.editingTheme = {...theme};
            this.isEditingTheme = true;
            this.isCreatingTheme = false;
            this.clearMessages();
        },

        // Показване на форма за редактиране на подточка
        showEditThemeItemForm(theme, themeItem) {
            this.editingThemeItem = {...themeItem};
            this.selectedTheme = {...theme};
            this.isEditingThemeItem = true;
            this.isCreatingThemeItem = false;
            this.clearMessages();
        },

        // Създаване на нова тема
        createTheme() {
            const vm = this;
            vm.isLoading = true;
            vm.error = null;

            axios.post('/api/specialty/' + SPEC + '/themes/create/', this.newTheme, {
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': CSRF_TOKEN
                }
            })
                .then(function(response) {
                    // Добавяме новата тема към списъка
                    vm.themes.push(response.data);
                    vm.isLoading = false;
                    vm.isCreatingTheme = false;
                    vm.success = "Темата е създадена успешно!";

                    // Сортираме темите по номер
                    vm.themes.sort((a, b) => a.num - b.num);
                })
                .catch(function(error) {
                    console.error("Грешка при създаване на тема:", error);
                    vm.error = "Възникна грешка при създаване на темата.";
                    vm.isLoading = false;
                });
        },

        // Създаване на нова подточка към избраната тема
        createThemeItem() {
            if (!this.selectedTheme) {
                this.error = "Моля, изберете тема първо!";
                return;
            }

            const vm = this;
            vm.isLoading = true;
            vm.error = null;

            axios.post('/api/themes/' + this.selectedTheme.id + '/items/create/', this.newThemeItem, {
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': CSRF_TOKEN
                }
            })
                .then(function(response) {
                    // Добавяме новата подточка към избраната тема
                    if (!vm.selectedTheme.items) {
                        vm.selectedTheme.items = [];
                    }
                    vm.selectedTheme.items.push(response.data);
                    vm.isLoading = false;
                    vm.isCreatingThemeItem = false;
                    vm.success = "Подточката е създадена успешно!";

                    // Сортираме подточките по номер
                    vm.selectedTheme.items.sort((a, b) => a.item - b.item);
                })
                .catch(function(error) {
                    console.error("Грешка при създаване на подточка:", error);
                    vm.error = "Възникна грешка при създаване на подточката.";
                    vm.isLoading = false;
                });
        },

        // Обновяване на съществуваща тема
        updateTheme() {
            if (!this.editingTheme) {
                this.error = "Няма избрана тема за редактиране!";
                return;
            }

            const vm = this;
            vm.isLoading = true;
            vm.error = null;

            axios.put('/api/themes/' + this.editingTheme.id + '/update/', this.editingTheme, {
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': CSRF_TOKEN
                }
            })
                .then(function(response) {
                    // Обновяваме темата в списъка
                    const index = vm.themes.findIndex(t => t.id === vm.editingTheme.id);
                    if (index !== -1) {
                        // Запазваме подточките, ако не са върнати в отговора
                        if (!response.data.items && vm.themes[index].items) {
                            response.data.items = vm.themes[index].items;
                        }
                        vm.themes[index] = response.data;

                        // Ако това е избраната тема, обновяваме и нея
                        if (vm.selectedTheme && vm.selectedTheme.id === vm.editingTheme.id) {
                            vm.selectedTheme = response.data;
                        }
                    }

                    vm.isLoading = false;
                    vm.isEditingTheme = false;
                    vm.success = "Темата е обновена успешно!";

                    // Сортираме темите по номер
                    vm.themes.sort((a, b) => a.num - b.num);
                })
                .catch(function(error) {
                    console.error("Грешка при обновяване на тема:", error);
                    vm.error = "Възникна грешка при обновяване на темата.";
                    vm.isLoading = false;
                });
        },

        // Обновяване на съществуваща подточка
        updateThemeItem() {
            if (!this.editingThemeItem) {
                this.error = "Няма избрана подточка за редактиране!";
                return;
            }

            const vm = this;
            vm.isLoading = true;
            vm.error = null;

            axios.put('/api/theme-items/' + this.editingThemeItem.id + '/update/', this.editingThemeItem, {
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': CSRF_TOKEN
                }
            })
                .then(function(response) {
                    // Обновяваме подточката в избраната тема
                    if (vm.selectedTheme && vm.selectedTheme.items) {
                        const itemIndex = vm.selectedTheme.items.findIndex(item => item.id === vm.editingThemeItem.id);
                        if (itemIndex !== -1) {
                            vm.selectedTheme.items[itemIndex] = response.data;
                        }

                        // Сортираме подточките по номер
                        vm.selectedTheme.items.sort((a, b) => a.item - b.item);
                    }

                    vm.isLoading = false;
                    vm.isEditingThemeItem = false;
                    vm.success = "Подточката е обновена успешно!";
                })
                .catch(function(error) {
                    console.error("Грешка при обновяване на подточка:", error);
                    vm.error = "Възникна грешка при обновяване на подточката.";
                    vm.isLoading = false;
                });
        },

        // Отмяна на редактиране/създаване
        cancelAction() {
            this.isCreatingTheme = false;
            this.isCreatingThemeItem = false;
            this.isEditingTheme = false;
            this.isEditingThemeItem = false;
            this.clearMessages();
        },

        // Изчистване на съобщенията
        clearMessages() {
            this.error = null;
            this.success = null;
        },

        // Форматиране на данните за общия брой задачи
        getTasksTotal(theme) {
            return theme.tasks_knowledge + theme.tasks_comprehension + theme.tasks_application + theme.tasks_analysis;
        },

        // Форматиране на данните за общия брой точки
        getPointsTotal(item) {
            return item.knowledge + item.comprehension + item.application + item.analysis;
        },

        // Изтриване на подточка от тема
        deleteThemeItem(theme, themeItem) {
            const vm = this;
            const id = themeItem.id;
            vm.isLoading = true;
            vm.error = null;
            vm.success = null;
            vm.selectedTheme = {...theme}

            // Първо проверяваме дали подточката има свързани задачи
            axios.get(`/api/theme-items/${themeItem.id}/tasks-count/`)
                .then(response => {
                    const tasksCount = response.data.count;

                    // Съставяме съобщение за потвърждение
                    let confirmMessage = `Сигурни ли сте, че искате да изтриете подточка ${themeItem.item}. ${themeItem.title}?`;

                    // Ако има свързани задачи, предупреждаваме потребителя
                    if (tasksCount > 0) {
                        confirmMessage += `\n\nВНИМАНИЕ: Това действие ще изтрие също ${tasksCount} свързани задачи!`;
                    }

                    // Показваме диалог за потвърждение
                    if (confirm(confirmMessage)) {
                        // Изпращаме заявка за изтриване на подточката
                        axios.delete(`/api/theme-items/${themeItem.id}/delete/`, {
                            headers: {
                                'X-CSRFToken': CSRF_TOKEN
                            }
                        })
                            .then(response => {
                                // Премахваме изтритата подточка от списъка
                                if (vm.selectedTheme && vm.selectedTheme.items) {
                                    const themeIndex = vm.themes.findIndex(theme => theme.id === vm.selectedTheme.id);
                                    if (themeIndex !== -1) {
                                        vm.themes[themeIndex].items = vm.themes[themeIndex].items.filter(item => item.id !== id)
                                        }
                                }

                                vm.success = "Подточката беше успешно изтрита.";
                                vm.isLoading = false;
                            })
                            .catch(error => {
                                console.error("Грешка при изтриване на подточка:", error);

                                // Показваме съобщение за грешка
                                vm.error = "Възникна грешка при изтриване на подточката.";

                                // Ако има по-подробна информация за грешката, я добавяме
                                if (error.response && error.response.data && error.response.data.error) {
                                    vm.error += ` Детайли: ${error.response.data.error}`;
                                }

                                vm.isLoading = false;
                            });
                    } else {
                        vm.isLoading = false;
                    }
                })
                .catch(error => {
                    console.error("Грешка при проверка за свързани задачи:", error);
                    vm.error = "Не можем да проверим дали има свързани задачи. Моля, опитайте отново.";
                    vm.isLoading = false;
                });
        },

    },
    created: function(){
        this.activeTab = 0
        this.loadUserDetails();
        this.loadSpecialty();
        // Зареждаме темите при създаване на компонента
        this.loadThemes();
        this.editingThemeItem = {...this.newThemeItem}
        this.editingTheme = {...this.newTheme}
    }
}

Vue.createApp(App).mount('#main')
