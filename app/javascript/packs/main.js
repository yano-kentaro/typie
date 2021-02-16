/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

// import Vue from 'vue';
// import Vuetify from "vuetify";
// import "vuetify/dist/vuetify.min.css";
// import Landing from '../Landing.vue';
// import Sign_up from '../Sign_up.vue';

// Vue.use(Vuetify);
// const vuetify = new Vuetify();

// document.addEventListener('DOMContentLoaded', () => {
//   const landing = new Vue({
//     vuetify,
//     render: h => h(Landing)
//   }).$mount()
//   document.body.appendChild(landing.$el);

//   console.log(landing);
// })


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


import Vue from 'vue/dist/vue.esm'

import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import Landing from '../Landing.vue';
import Books from '../Books.vue';

Vue.use(Vuetify);
const vuetify = new Vuetify();

document.addEventListener('DOMContentLoaded', () => {
  const landing = new Vue({
    vuetify,
    el: '#landing',
    data: {
    },
    components: { Landing }
  });
  const books = new Vue({
    vuetify,
    el: '#books',
    data: {
    },
    components: { Books }
  });

})
//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//



// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue'
// import Vuetify from "vuetify"
// import "vuetify/dist/vuetify.min.css"
// import Landing from '../Landing.vue'

// Vue.use(Vuetify);
// const vuetify = new Vuetify();

// Vue.use(TurbolinksAdapter)
// document.addEventListener('turbolinks:load', () => {
//   const landing = new Vue({
//     vuetify,
//     el: '#landing',
//     data: () => {
//       return {
//         message: "Can you say hello?"
//       }
//     },
//     components: { Landing }
//   })
// })
