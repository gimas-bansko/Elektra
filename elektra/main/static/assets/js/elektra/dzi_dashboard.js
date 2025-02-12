const App = {
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
        ast:'-****-'
        }
     },

    methods: {
    },
    created: function(){
        this.status = 0
    }
}

Vue.createApp(App).mount('#main')