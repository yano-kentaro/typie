<template>
  <v-app id="books">
    <div class="bg-img-books">

    </div>
  </v-app>
</template>

<script>
import axios from 'axios';

export default {
}
</script>

<style scoped>
.bg-img-books {
  background-image: url(/computer-1209641_1920.jpg);
  min-height: 100vh;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>