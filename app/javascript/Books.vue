<template>
  <v-app id="books">
    <div class="bg-img-books">
      <v-container class="container">
        <v-row class="row">
          <v-col class="col" cols="12" md="2.4" lg="2" xl="2" v-for="book in books" :key="book.id">
            <v-card v-ripple class="book" hover color="primary" dark>
              <v-card-title>{{book.title}}</v-card-title>
              <v-card-subtitle># {{book.languages[0].name}}</v-card-subtitle>
              <v-card-title>{{`${book.book_words.length}words`}}<br>Score: 1,250pt</v-card-title>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </div>
  </v-app>
</template>

<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      books: "books"
    }
  },
  mounted() {
    this.setBook();
  },
  methods: {
    setBook: function() {
      axios.get('/api/books')
      .then(response=>(
        this.books = response.data
      ))
    }
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