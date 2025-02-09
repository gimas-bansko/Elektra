const EDIT_NEW_QUESTION='Създаване на нов въпрос'
const EDIT_OLD_QUESTION='Редактиране на въпрос'

const App = {
    data() {
     return {
        flagNewItem: false,
        editMode: EDIT_NEW_QUESTION,
        current_level:0,
        current_item: 0,
        theme_num:0,
        question: {
                    id: 1,
                    text: "Въпрос от ниво знание на тема 1 точка 1",
                    type: 1,
                    picture: null,
                    group: 0,
                    item: 1,
                    mark_red: false,
                    mark_green: true,
                    mark_yellow: true,
                    deletedOptions:[],
                    options: [
                        {
                            id: 1,
                            leading_char: "3",
                            text: "опция 1 на въпрос 1",
                            value: "",
                            value_name: "",
                            checked: true,
                            task: 1
                        }
                    ],
                    },
        theme: [],
        listOfThemes: [],
        user:{},
        }
     },
    methods:{
        verifyQuestionQty(level, idx, value){
            if (checkQuestionsQty(level, idx)==value){return true}
            else {return false}
        },
        checkQuestionsQty(level, idx){
            let q=0
            let th = this.theme[idx]
            if (level==1){
                if ((th.q_knowledge==0)&&(th.knowledge==0)) {q=0}
                else if (th.q_knowledge<th.knowledge) {q=1}
                else if (th.q_knowledge<2*th.knowledge) {q=2}
                else {q=3}
                }
            if (level==2){
                if ((th.q_comprehension==0)&&(th.comprehension==0)) {q=0}
                else if (th.q_comprehension<th.comprehension) {q=1}
                else if (th.q_comprehension<2*th.comprehension) {q=2}
                else {q=3}
                }
            if (level==3){
                if ((th.q_application==0)&&(th.application==0)) {q=0}
                else if (th.q_application<th.application) {q=1}
                else if (th.q_application<2*th.application) {q=2}
                else {q=3}
                }
            if (level==4){
                if ((th.q_analysis==0)&&(th.analysis==0)) {q=0}
                else if (th.q_analysis<th.analysis) {q=1}
                else if (th.q_analysis<2*th.analysis) {q=2}
                else {q=3}
                }
            return q
        },
        getLevelName(level){
            let name=''
            if (level==1){name='знание'}
            if (level==2){name='разбиране'}
            if (level==3){name='приложение'}
            if (level==4){name='анализ'}
            return name
        },
        onImageChange(e){
            const file = e.target.files[0]
            this.question.picture = URL.createObjectURL(file)
            console.log('this.question.item='+this.question.item)
            for (th of this.theme){console.log(th)}
            // this.theme[this.question.item].picture = URL.createObjectURL(file)
            let formData = new FormData();
            formData.append('id', this.question.id)
            formData.append('picture', file)
            let url = ''
            const lvl=this.current_level
            if (lvl == 1){url = '/api/TaskKnowledgeFile/'}
            else if (lvl == 2){url = '/api/TaskComprehensionFile/'}
            else if (lvl == 3){url = '/api/TaskApplicationFile/'}
            else if (lvl == 4){url = '/api/TaskAnalysisFile/'}
            axios.post(url, formData, {headers: {'X-CSRFToken':CSRF_TOKEN, 'Content-Type': 'multipart/form-data'}})
            txt = 'Променена/качена картинка (тема '+this.theme_num+'; въпрос id='+this.question.id+')'
            this.sendLogRecord(txt)
        },
        make_q(itm, lvl, id){ // превключва въпрос в режим на редактиране
            const vm = this;
            vm.flagNewItem = false
            vm.current_item = vm.theme[itm].id
            vm.current_level = lvl
            vm.question.item = itm
            let lvl_name = ' от ниво '
            console.log('EDIT: level=', lvl,' item=',itm, 'new id=', id)
            if (lvl == 1){
                vm.question = vm.theme[itm].tasks_knowledge[id]
                lvl_name += 'знание'
            } else if (lvl == 2){
                vm.question = vm.theme[itm].tasks_comprehension[id]
                lvl_name += 'разбиране'
            } else if (lvl == 3){
                vm.question = vm.theme[itm].tasks_application[id]
                lvl_name += 'приложение'
            } else {
                vm.question = vm.theme[itm].tasks_analysis[id]
                lvl_name += 'анализ'
            }
            vm.editMode = EDIT_OLD_QUESTION + lvl_name
            this.question.deletedOptions = []
        },
        make_new_q(itm, lvl){ // създава нов въпрос от съответното ниво към съответната точка от темата
            const vm=this
            axios({
                method:'POST',
                url:'/api/TaskNewQuestionBody/',
                headers:{
                    'X-CSRFToken':CSRF_TOKEN,
                    //'Access-Control-Allow-Origin':'*',
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
                data:{
                    level: lvl,
                    item: itm,
                }
            })
            .then(response => {
                const id = response.data
                axios.get('/api/theme_items/'+vm.listOfThemes[vm.theme_num].id)
                    .then(function(response){
                        vm.theme = response.data
                        vm.countThemeQuestions()
                        console.log('level=', lvl,' item=',itm, 'new id=', id)
                        txt = 'Създаден нов въпрос по тема '+vm.theme_num+' ; въпрос id='+vm.question.id+')'
                        vm.sendLogRecord(txt)
                    })
            // this.reloadItem()
            })
            .catch(error => {
                throw("Error: ",error);
            })
        },
        countThemeQuestions(){
            this.theme.forEach((th) => {
                th.q_knowledge=0
                th.q_comprehension=0
                th.q_application=0
                th.q_analysis=0
                th.tasks.forEach((qst) => {
                    if (qst.level==1){th.q_knowledge+=1}
                    else if (qst.level==2){th.q_comprehension+=1}
                    else if (qst.level==3){th.q_application+=1}
                    else {th.q_analysis+=1}
                    });
                });
        },
        addEmptyOption(){
            let newOption = {
                            id: 0,
                            leading_char: "",
                            text: "",
                            value: "",
                            value_name: "",
                            checked: false,
                            task:this.question.id,
                        }
            this.question.options.push(newOption)
            this.flagNewItem = true
        },
        deleteOption(idx){
            console.log(this.question.deletedOptions)
            if (this.question.options[idx].id>0){
                this.question.deletedOptions[this.question.deletedOptions.length]=this.question.options[idx].id
                console.log(this.question.deletedOptions.toString())
                }
            this.question.options.splice(idx, 1)
            this.flagNewItem = true
        },
        deleteTask(idn,lvl){
            vm = this
            axios({
                method:'POST',
                url:'/api/TaskDelete/',
                headers:{
                    'X-CSRFToken':CSRF_TOKEN,
                    //'Access-Control-Allow-Origin':'*',
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
                data:{
                    id: idn,
                    level: lvl,
                }
            })
            .then(response => {
                console.log('success - item was deleted');
                vm.reloadItem()
                txt = 'Изтрит е въпрос от тема '+vm.theme_num+' ; въпрос id='+idn+')'
                vm.sendLogRecord(txt)
            })
            .catch(error => {
                throw("Error: ",error);
            })
        },
        saveOption(i){
            vm = this
            axios({
                method:'POST',
                url:'/api/TaskSaveQuestionOption/'+this.current_level+'/'+this.question.options[i].id+'/'+this.question.id+'/',
                headers:{
                    'X-CSRFToken':CSRF_TOKEN,
                    //'Access-Control-Allow-Origin':'*',
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
                data:{
                    id: this.question.options[i].id,
                    ids: this.question.options[i].id,
                    task: this.question.options[i].task,
                    leading_char: this.question.options[i].leading_char,
                    text: this.question.options[i].text,
                    value: this.question.options[i].value,
                    value_name: this.question.options[i].value_name,
                    checked: this.question.options[i].checked,
                }
            })
            .then(response => {
                txt = 'Запазени промени във въпрос по тема '+vm.theme_num+' ; въпрос id='+vm.question.id+')'
                vm.sendLogRecord(txt)
            })
            .catch(error => {
                throw("Error: ",error);
            })
        },
        saveQuestionBody(){
            vm = this
            axios({
                method:'POST',
                url:'/api/TaskSaveQuestionBody/'+this.current_level+'/',
                headers:{
                    'X-CSRFToken':CSRF_TOKEN,
                    //'Access-Control-Allow-Origin':'*',
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
                data:{
                    id: this.question.id,
                    ids: this.question.id,
                    text: this.question.text,
                    type: this.question.type,
                    group: this.question.group,
                    mark_red: this.question.mark_red,
                    mark_green: this.question.mark_green,
                    mark_yellow: this.question.mark_yellow,
                }
            })
            .then(response => {
                console.log('success - item was saved');
                for (ggg=0; ggg < vm.question.options.length; ggg++){
                    console.log(vm.question.options[ggg])
                    vm.saveOption(ggg)}
                if(this.flagNewItem){
                    this.flagNewItem = false
                    vm.reloadItem()
                    }
            })
            .catch(error => {
                throw("Error: ",error);
            })
        },
        save(){
            /* 1. премахвам изтритите опции на въпроса*/
            axios({
                method:'POST',
                url:'/api/TaskDelItem/',
                headers:{
                    'X-CSRFToken':CSRF_TOKEN,
                    //'Access-Control-Allow-Origin':'*',
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
                data:{
                    level: this.current_level,
                    ids: this.question.deletedOptions,
                }
            })
            .then(response => {
                console.log('success - item was deleted');
                this.saveQuestionBody()
            })
            .catch(error => {
                throw("Error: ",error);
            })
            /* още код */
        },
        reloadItem(){
            const vm = this;
            axios.get('/api/theme_items/'+vm.listOfThemes[vm.theme_num].id)
            .then(function(response){
                vm.theme = response.data
                vm.countThemeQuestions()
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
        loadThemes(spec_id){
            const vm = this;
            axios.get('/api/theme_nums/'+spec_id) // темите са различни за всяка специалност
            .then(function(response){
                vm.listOfThemes = response.data
                for (i=0; i< vm.listOfThemes.length; i++){
                    if (vm.listOfThemes[i].num == vm.user.theme){ vm.theme_num = i}
                    }
                vm.reloadItem()
            })
        },
        loadUserDetails(){
            const vm = this;
            axios.get('/api/context/')
            .then(function(response){
                vm.user = response.data
                vm.loadThemes(vm.user.speciality)
            })
        }
    },
    created: function(){
        this.loadUserDetails();
    }
}

Vue.createApp(App).mount('#main')
