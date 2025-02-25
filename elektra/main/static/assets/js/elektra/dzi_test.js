const App = {
    delimiters: ['[[', ']]'], // Променяме синтаксиса на [[ ]]
    data() {
        return {
            points_total:60,
            status: 0, //0 - начално положение; 1 -  тече тест; 2 - край на теста и показваме резултата
            timer: {
                h: 0,
                m: 0,
                s: 0,
                id: 0,
            },
            test: [],
            theme: {},

            user:{},
            listOfThemes: [
                {
                    "id": 1,
                    "num": 1,
                    "title": "Микропроцесор. Архитектура на микропроцесор",
                    "tasks_total": 24,
                    "tasks_knowledge": 9,
                    "tasks_comprehension": 8,
                    "tasks_application": 3,
                    "tasks_analysis": 4,
                    "specialty": 1
                },
                {
                    "id": 1,
                    "num": 1,
                    "title": "Микропроцесор. Архитектура на микропроцесор",
                    "tasks_total": 24,
                    "tasks_knowledge": 9,
                    "tasks_comprehension": 8,
                    "tasks_application": 3,
                    "tasks_analysis": 4,
                    "specialty": 1
                },
            ],
            theme_num:1,
        }
    },

    methods: {
        removeGroup(t,max){ // търси индекс на елемент с атрибут group=g в масива t
            let f = false
            while (!f){
                let i = 0
                let g = 0
                while (t[i]&&(g==0)){
                    if (!(t[i].group==0)){
                        g = t[i].group
                    }
                    i++
                }
                if (!(g == 0)){  // има група
                    let group_idx=[]
                    i = 0
                    for(task of t){
                        if(task.group==g){group_idx.push(i)}
                        i++
                    }
                    // избирам по случаен начин 1 от елементите на групата и го премахвам от списъка с въпросите
                    if((group_idx.length>1)&&(max<t.length)) {
                        i = group_idx[Math.floor(Math.random() * group_idx.length)]
                        t.splice(i,1)
                    }
                    else{t[group_idx[0]].group=0}
                }
                else {f = true}
            }// while f
        },
        removeExtraTasks(t,max){
            let n = 0
            while (max < t.length){
                n = Math.floor(Math.random() * t.length)
                t.splice(n, 1)
            }
        },
        valueTasks(t, points){ // оценяване на задачите от дадено ниво
            let total = 0
            let numOkBase = 0 // брой верни отговори по ключ
            let numOk = 0 // брой дадени верни отговори
            let numAnswers = 0 // брой дадени отговори
            let taskTotal = 0 // точки за конкретния въпрос
            let numOptions = 0 // брой отговори към въпроса
            if (t.length > 0){
                for (task of t){
                    numOkBase = 0; numOk = 0; numAnswers = 0; taskTotal = 0; numOptions = 0
                    if (task.type < 3){ // тип 1 или 2 - затворен въпрос
                        for(option of task.options){
                            numOptions++
                            if (option.checked_t){numAnswers++}
                            if (option.checked){numOkBase++}
                            if (option.checked_t && option.checked){numOk++}
                        }
                        if ((numOkBase >= numOk)&&(numOkBase>0)){
                            taskTotal += Math.round(points*numOk/numOkBase)
                        }
                    }
                    else if (task.type < 5){ // тип 1 или 2 - съпоставяне
                        for(option of task.options){
                            numOptions++
                            if (option.value_t){numAnswers++}
                            if (option.value_t && option.value){numOk++}
                        }
                        if(numOptions>0){ taskTotal += points*numOk/numOptions }
                    }
                    else { // отворен отговор
                        for(option of task.options){
                            numOptions++
                            if (task.options[0].value_t == option.value){numOk = 1}
                        }
                        taskTotal += points*numOk
                    }
                    total = total + taskTotal
                }
                this.points_total += total
            }
        },
        stopTest(){
            this.status = 2
            clearInterval(vm.timer.id)
            // оценка на резултата
            this.points_total = 0
            for(item of this.test){
                this.valueTasks(item.tasks_knowledge, 2)
                this.valueTasks(item.tasks_comprehension, 4)
                this.valueTasks(item.tasks_application, 6)
                this.valueTasks(item.tasks_analysis, 8)
            }
            this.points_total = Math.round(this.points_total)
            this.sendTestResult()
        },
        sendTestResult(){
            const vm=this
            time = ((this.timer.h * 60) + this.timer.m) * 60 +this.timer.s
            axios({
                method:'POST',
                url:'/diki/api/SaveTestResult/',
                headers:{
                    'X-CSRFToken':CSRF_TOKEN,
                    //'Access-Control-Allow-Origin':'*',
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
                data:{
                    theme: this.theme.num,
                    points: this.points_total,
                    time: time
                }
            })
                .then(response => {
                })
                .catch(error => {
                    throw("Error: ",error);
                })
        },

        startTest(){
            vm = this
            vm.status = 1
            vm.timer.h = 0
            vm.timer.m = 0
            vm.timer.s = 0
            vm.testTimer()
            const theme_num_id=vm.listOfThemes[vm.theme_num]
        },
        
        testTimer(){
            vm=this
            if(vm.status===1){
                vm.timer.s += 1
                if(vm.timer.s>59){
                    vm.timer.s = 0
                    vm.timer.m += 1
                    if(vm.timer.m>59){
                        vm.timer.m = 0
                        vm.timer.h += 1
                    }
                }
            }
        },
        loadTheme(vm){
            axios.get('/api/theme_items/'+vm.listOfThemes[vm.theme_num].id+'/')
                .then(function(response){
                    vm.theme = response.data
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
        loadThemes(spec_id){
            const vm = this;
            axios.get('/api/theme_nums/'+spec_id+'/') // темите са различни за всяка специалност
                .then(function(response){
                    vm.listOfThemes = response.data
                    for (i=0; i< vm.listOfThemes.length; i++){
                        if (vm.listOfThemes[i].num == vm.user.theme){ vm.theme_num = i}
                    }
                    vm.loadTheme(vm)
                })
        },
        changeTheme(theme_num){
            const vm = this;
            axios.get('api/set_user_theme/'+theme_num+'/') // темите са различни за всяка специалност
                .then(function(response){
                    vm.loadUserDetails()
                })
        },
    },
    created: function(){
        this.status = 0
        this.loadUserDetails();
    }
}

Vue.createApp(App).mount('#main')
