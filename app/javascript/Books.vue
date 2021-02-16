<template>
  <v-app id="books">
    <v-btn href="/users/sign_out" method="delete">ログアウト</v-btn>
  </v-app>
</template>

<script>
import axios from 'axios';

export default {
  methods: {
    logOut: function() {
      axios.delete('/users/sign_out')
      .then
    }
  }
}
</script>