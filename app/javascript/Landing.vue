<template>
  <v-app id="landing">
    <div class="bg-img">

      <div class="contents">
        <div class="catch-copy">
          <h1>Typing for Programer</h1>
          <h2>with Typie</h2>
        </div>
        <div class="introduce">
          <div class="introduce-button">
            <v-btn width="300" color="primary" rounded x-large @click="toggleCarouselFlag">
              <v-spacer></v-spacer><v-spacer></v-spacer><v-spacer></v-spacer>HOW TO USE<v-spacer></v-spacer>
              <v-icon>mdi-comment-question-outline</v-icon><v-spacer></v-spacer>
            </v-btn></div>
            <div id="login">
              <v-spacer></v-spacer>
              <v-btn width="150" href="/users/sign_up" color="green darken-1" rounded x-large dark>
              <v-icon>mdi-human-greeting</v-icon><v-spacer></v-spacer>
                SIGN UP<v-spacer></v-spacer>
              </v-btn>
              <v-spacer></v-spacer>
              <v-btn width="150" href="/users/sign_in" color="teal lighten-1" rounded x-large dark>
              <v-spacer></v-spacer><v-spacer></v-spacer>
                LOG IN<v-spacer></v-spacer><v-icon style="transform: scale(-1, 1);">mdi-human-greeting</v-icon><v-spacer></v-spacer>
              </v-btn>
              <v-spacer></v-spacer>
            </div>
        </div>
      </div>

      <v-dialog v-model="dialogCarouselFlag" width="800">
        <v-card color="black" height="500">
          <v-carousel
          :continuous="false"
          >
            <v-carousel-item
            v-for="(item, i) in items"
            :key="i"
            :src="item.src"
            >
            <v-card-title class="headline primary">
              <v-spacer/><span v-text="item.text"></span><v-spacer/>
            </v-card-title>
            </v-carousel-item>
          </v-carousel>
        </v-card>
      </v-dialog>

    </div>
  </v-app>
</template>

<script>
export default {
  data: function() {
    return {
      dialogCarouselFlag: false,
      items: [
        { src: '/carousel_01.png', text: "Typie is a typing app for Engineers!" },
        { src: '/carousel_02.png', text: "Typie extracts English words from your Source Code!" },
        { src: '/carousel_03.png', text: "You can practice typing with the words!" },
        { src: '/carousel_04.png', text: "You can check the typing result immediately." },
        { src: '/carousel_05.png', text: "You can edit the title, language, and color." },
      ],
    }
  },
  methods: {
    toggleCarouselFlag: function() {
      this.dialogCarouselFlag = !this.dialogCarouselFlag
    },
  },
}
</script>

<style scoped>
.bg-img {
  background-image: url(/student-849822_1280.jpg);
  min-height: 100vh;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  display: flex;
  justify-content: center;
  align-items: center;
}

.contents {
  height: 50%;
  width: 70%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;

}

.catch-copy {
  height: 80%;
  border-radius: 30px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color : #ffffff;
  text-shadow: 
      4px  4px 3px #00007f,
      -4px  4px 3px #00007f,
      4px -4px 3px #00007f,
      -4px -4px 3px #00007f,
      4px  0px 3px #00007f,
      0px  4px 3px #00007f,
      -4px  0px 3px #00007f,
      0px -4px 3px #00007f;
  letter-spacing: 5px;
  font-family: 'PT Sans', sans-serif;
}

h1 {
  font-size: 5rem;
}

h2 {
  font-size: 3rem;
}

.introduce {
  width: 50%;
  padding-top: 50px;
}

.introduce-button {
  display: flex;
  justify-content: center;
}

a {
  transition: all .2s ease;
}

a:hover {
  transform: scale(1.15, 1.15);
}

button {
  transition: all .2s ease;
}

button:hover {
  transform: scale(1.15, 1.15);
}

#login {
  height: 40%;
  width: 100%;
  padding-top: 40px;
  display: flex;
}

span {
  font-family: "PT Sans", sans-serif, serif;
  font-size: 20pt;
  letter-spacing: 2px;
}

</style>