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
              <div id="sign-up"><v-btn color="green darken-1" rounded x-large dark>新規登録</v-btn></div>
              <div id="sign-in"><v-btn color="teal lighten-1" rounded x-large dark>ログイン</v-btn></div>
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
  background-image: url(../assets/images/student-849822.jpg);
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
  width: 60%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;

}

.catch-copy {
  background-image: url(../assets/images/4208448_l.jpg);
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  border-top-left-radius: 30px;
  border-top-right-radius: 30px;
  border-bottom-right-radius: 30px;
  border-bottom-left-radius: 30px;
  height: 80%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;

}

h1 {
  font-size: 4rem;
  font-family: serif;
}

h2 {
  font-size: 2.5rem;
  font-family: serif;
}

.introduce {
  width: 50%;
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