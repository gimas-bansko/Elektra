const App = {
    delimiters: ['[[', ']]'], // Променяме синтаксиса на [[ ]]
    data() {
        return {
            listOfThemes: [],
            user:{},
            randomOrder: false,
            allChecked:false,
            activeTab:0,
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
                        checked: false
                    }));
                })
        },
        loadUserDetails(){
            const vm = this;
            axios.get('/api/context/')
                .then(function(response){
                    vm.user = response.data
                    vm.loadThemes(vm.user.speciality)
                })
        },
        setAllChecked(value) {
            this.listOfThemes = this.listOfThemes.map(theme => ({
                ...theme,
                checked: value
            }));
        },
        generate(){},
    },
    created: function(){
        this.status = 0
        this.loadUserDetails();
    }
}

Vue.createApp(App).mount('#main')
