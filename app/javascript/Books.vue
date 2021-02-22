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
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="red" dark @click="toggleShowDialog(showBook.id)">cancel</v-btn>
            <v-spacer></v-spacer>
            <v-btn color="red" dark @click="toggleDeleteDialog(showBook.id)">Delete</v-btn>
            <v-spacer></v-spacer>
            <v-btn color="primary" @click="toggleTypingModal(showBook.id)">Typing</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="dialogDeleteFlag" width="400">
        <v-card>
          <v-card-title class="headline red white--text" primary-title>
            Confirm
          </v-card-title>
          <v-spacer></v-spacer>
          <v-card-text>
            <p>本当に削除しますか？</p>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
            <v-btn color="red" dark @click="toggleDeleteDialog(showBook.id)">cancel</v-btn>
            <v-spacer></v-spacer>
            <v-btn color="red" dark @click="deleteBook(showBook.id)">Delete</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="modalTypingFlag" width="1000" persistent>
        <v-card>
          <v-card-title class="headline primary white--text">Typing Challenge</v-card-title>
          <v-divider></v-divider>
          <v-card-text>{{showBook.title}}</v-card-text>
          <v-card-actions>
            <v-btn color="red" dark @click="toggleTypingModal(showBook.id)">cancel</v-btn>
            <v-spacer></v-spacer>
            <v-btn color="primary" @click="beginTyping()">start</v-btn>
          </v-card-actions>
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
      dialogDeleteFlag: false,
      typingWords: "typingWords",
      modalTypingFlag: false,
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
      ));
    },
    toggleShowDialog: function(id) {
      axios.get('/api/books/' + id)
      .then(response=>{
        this.showBook = response.data
      });
      this.id = id
      this.dialogShowFlag = !this.dialogShowFlag
    },
    deleteBook: function(id) {
      axios.delete('/api/books/' + this.id)
      .then(response=> {
        this.setBook();
      });
      this.dialogDeleteFlag = !this.dialogDeleteFlag
      this.dialogShowFlag = !this.dialogShowFlag
    },
    toggleDeleteDialog: function(id) {
      this.id = id
      this.dialogDeleteFlag = !this.dialogDeleteFlag
    },
    toggleTypingModal: function(id) {
      this.id = id
      this.modalTypingFlag = !this.modalTypingFlag
      this.dialogShowFlag = !this.dialogShowFlag
    },
  }
}
      // axios.typing('/api/books/' + this.id)
      // .then(response=> {
      //   this.typingWords = response.data
      // });

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

button {
  transition: all .2s ease;
}

button:hover {
  transform: scale(1.15, 1.15);
}

</style>