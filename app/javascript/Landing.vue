<template>
  <v-app id="landing">
    <div class="bg-img">
      <div class="contents">
        <div class="catch-copy">
          <h1>Typing for Programer</h1>
          <h2>with Typie</h2>
        </div>
        <div class="introduce">
          <div class="introduce-button"><v-btn color="primary" block rounded x-large>HOW TO USE</v-btn></div>
            <div id="login">
              <div id="sign-up"><v-btn href="/users/sign_up" color="green darken-1" rounded x-large dark>新規登録</v-btn></div>
              <div id="sign-in"><v-btn href="/users/sign_in" color="teal lighten-1" rounded x-large dark>ログイン</v-btn></div>
            </div>
        </div>
      </div>
    </div>
  </v-app>
</template>

<script>
export default {
  
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
  width: 30%;
  padding-top: 50px;
}

#login {
  height: 40%;
  width: 100%;
  display: flex;
  justify-content: space-between;
  padding-top: 40px;
}

</style>