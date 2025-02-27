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
                    theme: vm.theme.num,
                    points: vm.points_total,
                    time: time
                }
            })
                .then(response => {
                })
        },

        startTest(){
            this.status = 1
            this.timer.h = 0
            this.timer.m = 0
            this.timer.s = 0
            this.timer.id = setInterval(this.testTimer, 1000)

            // формирам нов тест
            this.test.length = 0;
            let groups=[]
            let temp_question_list=[]
            let level_nip = 0 // брой въпроси в теста изисквани от НИП за точка/ниво
            //генерирам списък въпроси с изискваните от НИП брой и структура
            let item;
            for(item of this.theme){// обхождам темата точка по точка
                console.log(item)
                for (let level = 1; level < 5; level++){ //за всяко ниво по Блум
                    if (level===1) {level_nip=item.knowledge}
                    else if (level===2) {level_nip=item.comprehension}
                    else if (level===3) {level_nip=item.application}
                    else if (level===4) {level_nip=item.analysis}
                    console.log('level '+level+' ('+level_nip+')') // ПРОВЕРКА
                    temp_question_list.length = 0;
                    for(let question of item.tasks){ //обхождам точката въпрос по въпрос
                        if(question.level===level) {
                            temp_question_list.push(question)
                        }
                    }
                    // temp_question_list съдържа всички въпроси от текущото ниво за текущата точка
                    // махам доколкото е възможно групите
                    let num=0
                    let question=temp_question_list[num]
                    while ((num<temp_question_list.length)&&(temp_question_list.length > level_nip)){
                        question=temp_question_list[num]
                        if(question.group>0){ //въпросът е част от група
                            if (groups.includes(question.group)) {
                                //вече съм срещал тази група и затова махам въпроса
                                temp_question_list.splice(num,1)
                            }
                            else {// това е първият срещнат елемент от група question.group (не се съдържа в масива groups)
                                groups.push(question.group)
                                num++
                            }
                        }
                        else { //въпросът не е част от група
                            num++
                        }
                    }
                    // мамхам по случаен начин въпроси докато не останат толкова, колкото изисква НИП
                    while(temp_question_list.length > level_nip){
                        num=Math.floor(Math.random() * temp_question_list.length)
                        temp_question_list.splice(num,1)
                        }
                    for(question of temp_question_list){ // ПРОВЕРКА
                        console.log('question #'+question.id+' ( група #'+question.group+')')
                    }
                    // прехвърлям избраните въпроси от това ниво по тази точка в теста
                    for (let question of temp_question_list){
                        this.test.push(question)
                    }
                }
            }
            //разбърквам по случаен начин списъка с въпроси
            for (let i = this.test.length - 1; i > 0; i--) {
                // Избиране на случаен индекс от 0 до i
                const randomIndex = Math.floor(Math.random() * (i + 1));
                // Размяна на текущия елемент с елемента на случайния индекс
                [this.test[i], this.test[randomIndex]] = [this.test[randomIndex], this.test[i]];
            }
            //номерирам въпросите
            let num = 1
            for (let question of this.test){
                question.num=num
                num++;
            }
            for(let question of this.test){ // ПРОВЕРКА
                console.log('въпрос #'+question.num+' ( #'+question.id+')')
            }
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
