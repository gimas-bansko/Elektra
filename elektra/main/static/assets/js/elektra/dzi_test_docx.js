const App = {
    delimiters: ['[[', ']]'], // Променяме синтаксиса на [[ ]]
    data() {
        return {
            listOfThemes: [],
            user:{},
            randomOrder: false,
            allChecked:false,
            activeTab:0,
            generatedTests: [],
            generatingMode:0, //режима на генериране 0: избор; 1: генериране; 2: резултат
        }
    },
    computed: {
    },
    methods: {
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
        loadThemes(spec_id){
            const vm = this;
            axios.get('/api/theme_nums/'+spec_id+'/') // темите са различни за всяка специалност
                .then(function(response){
                    vm.listOfThemes = response.data.map(theme => ({
                        id: theme.id,
                        num: theme.num,
                        title: theme.title,
                        checked: false,
                        status: null,         // success | error | null
                    }));
                })
        },
        loadUserDetails(){
            const vm = this;
            axios.get('/api/context/')
                .then(function(response){
                    vm.user = response.data
                    vm.loadThemes(vm.user.speciality)
                    vm.loadGeneratedTests()
                })
        },
        setAllChecked(value) {
            this.listOfThemes = this.listOfThemes.map(theme => ({
                ...theme,
                checked: value,
                status: null,
            }));
        },
        loadGeneratedTests() {
            const vm = this;
            if (!vm.user.speciality || !vm.user.school) return; // предпазване от празни данни
            axios.get(`/api/generated-tests/${vm.user.speciality}/${vm.user.school}/`)
                .then(function(response) {
                    vm.generatedTests = response.data;
                });
        },
        formatDate(dateTimeStr) {
            if (!dateTimeStr) return '';
            const dt = new Date(dateTimeStr);
            const pad = n => n < 10 ? '0' + n : n;
            const day = pad(dt.getDate());
            const month = pad(dt.getMonth() + 1);
            const year = dt.getFullYear();
            const hour = pad(dt.getHours());
            const minute = pad(dt.getMinutes());
            const second = pad(dt.getSeconds());
            return `${day}.${month}.${year} г. ${hour}:${minute}:${second}`;
        },
        async generateAllTests() {
            const vm = this;
            const schoolId = vm.user.school;
            vm.generatingMode = 1
            for (const theme of vm.listOfThemes) {
                if( theme.checked===true ) {
                    try {
                        let s = 0
                        if (vm.randomOrder) {s=1}
                        let url = `/api/generate-test/${theme.id}/${schoolId}/${s}/`;
                        let response = await axios.get(url);
                        theme.status = response.data.success ? 'success' : 'error';
                        // По желание – тук можеш да направиш нещо с резултата, напр. да отбележиш, че е генериран успешно
                        // theme.generated = response.data.success;
                        // theme.test_url = response.data.test_url;
                    } catch (e) {
                        // По желание – отбелязване на грешка
                        // theme.error = true;
                        // theme.errorMsg = e.response?.data?.error || e.message;
                        // Можеш също да покажеш глобално съобщение за грешка
                        console.error(`Грешка при генериране на тема ${theme.id}:`, e);
                    }
                }
            }
            // По желание – обнови списъка с тестове или даден глобален индикатор
            vm.generatingMode = 2
        },
        setActiveTab(tab) {
            this.activeTab=tab;
            this.generatingMode = 0;
            this.loadGeneratedTests();
            this.setAllChecked(false);
        },
    },

    created: function(){
        this.status = 0
        this.loadUserDetails();
    }
}

Vue.createApp(App).mount('#main')
