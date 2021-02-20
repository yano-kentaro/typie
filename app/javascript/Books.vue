<template>
  <v-app id="books">
    <div class="bg-img-books">
      <v-container class="container">
        <v-row class="row">
          <v-col class="col" cols="12" md="2.4" lg="2" xl="2" v-for="indexBook in indexBooks" :key="indexBook.id">
            <v-card v-ripple class="book" hover color="primary" dark @click='toggleShowDialog(indexBook.id)'>
              <v-card-title>{{indexBook.title}}</v-card-title>
              <v-card-subtitle># {{indexBook.language}}</v-card-subtitle>
              <v-card-title>{{`${indexBook.book_words}words`}}<br>Score: 1,250pt</v-card-title>
            </v-card>
          </v-col>
        </v-row>

      <v-dialog v-model="dialogShowFlag" width="600">
        <v-card>
          <v-card-title class="headline primary white--text" primary-title>
            {{showBook.title}} #{{showBook.language}}
          </v-card-title>
        </v-card>
      </v-dialog>

      </v-container>
    </div>
  </v-app>
</template>

<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      indexBooks: "indexBooks",
      dialogShowFlag: false,
      showBook: "showBook",
    }
  },
  mounted() {
    this.setBook();
  },
  methods: {
    setBook: function() {
      axios.get('/api/books')
      .then(response=>(
        this.indexBooks = response.data
      ))
    },
    toggleShowDialog: function(id) {
      axios.get('/api/books/' + id)
      .then(response=>{
        this.showBook = response.data
      });
      this.id = id
      this.dialogShowFlag = !this.dialogShowFlag
    },
  }
}
</script>

<style scoped>
.bg-img-books {
  background-image: url(/computer-1209641_1920.jpg);
  height: 100vh;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  display: flex;
  justify-content: center;
  align-items: center;
}

.container {
  height: 75%;
  background-color: rgba(223, 223, 223, 0.3);
  margin-top: 50px;
  overflow: scroll;
}

.row {
  height: 200px;
}

.col {
  height: 100%;
  margin: auto;
}

.book {
  height: 100%;
  transition: all .3s ease;
}

.book:hover {
  transform: scale(1.1, 1.1);
}

</style>