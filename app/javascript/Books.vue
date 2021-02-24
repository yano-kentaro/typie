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
            <v-btn color="primary" @click="toggleTypingDialog(showBook.id)">Typing</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="dialogDeleteFlag" width="400">
        <v-card>
          <v-card-title class="headline red white--text" primary-title>
            Confirm
          </v-card-title>
          <v-divider></v-divider>
          <v-card-text>
            <p>本当に削除しますか？</p>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="red" dark @click="toggleDeleteDialog(showBook.id)">cancel</v-btn>
            <v-spacer></v-spacer>
            <v-btn color="red" dark @click="deleteBook(showBook.id)">Delete</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="dialogTypingFlag" width="500">
        <v-card>
          <v-card-title class="headline primary white--text">Typing Challenge</v-card-title>
          <v-divider></v-divider>
          <v-card-text>{{showBook.title}}</v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="red" dark @click="toggleTypingDialog(showBook.id)">cancel</v-btn>
            <v-spacer></v-spacer>
            <v-btn color="primary" @click="beginTyping(showBook.id)">start</v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="dialogCountDownFlag" width="400">
        <v-card>
          <v-progress-circular :size="400" width="30" color="primary" indeterminate style="font-size: 200px;">{{countDown}}</v-progress-circular>
        </v-card>
      </v-dialog>

      <v-dialog v-model="modalTypingFlag" width="500" persistent>
        <v-card style="font-family: Source Han Code JP; height: 25vh; overflow: auto;">
          <v-card-text style="font-size: 30px; padding-top: 30px;">{{displayWord}}</v-card-text>
          <v-text-field autofocus autocomplete="off" v-model="inputField" @keydown="judgeTyping" @keyup="nextWord" height="40px" style="height: 50px; font-size: 30px;"></v-text-field>
        </v-card>
      </v-dialog>

      <v-dialog v-model="dialogResultFlag" width="500">
        <v-card>
          <v-card-title>Result</v-card-title>
          <v-card-text>{{correctCount}}文字正解</v-card-text>
          <v-card-text>{{missCount}}文字ミス</v-card-text>
          <v-card-text>{{typingTime}}秒</v-card-text>
          <v-card-text>正答率:{{Math.floor(correctRate * 10000) / 100}}%</v-card-text>
          <v-card-text>スコア:{{typingScore}}pt</v-card-text>
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
      dialogTypingFlag: false,
      dialogCountDownFlag: false,
      countDown: 0,
      modalTypingFlag: false,
      displayWord: "",
      inputField: "",
      charIndex: 0,
      correctCount: 0,
      missCount: 0,
      dialogResultFlag: false,
      startTime: 0,
      finishTime: 0,
      typingTime: 0,
      correctRate: 0,
      typingScore: 0,
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
      this.dialogShowFlag = !this.dialogShowFlag
    },
    toggleTypingDialog: function(id) {
      this.id = id
      this.dialogTypingFlag = !this.dialogTypingFlag
      this.dialogShowFlag = !this.dialogShowFlag
    },
    beginTyping: function(id) {
      axios.get(`/api/books/${this.id}/typing`)
      .then(response=> {
        this.typingWords = response.data
      });
      this.id = id
      this.dialogTypingFlag = !this.dialogTypingFlag
      this.dialogCountDownFlag = !this.dialogCountDownFlag
      this.setCountDown();
    },
    setCountDown: function() {
      const sec = 3;
      let dt = new Date();
      let endDt = new Date(dt.getTime() + sec *1000);
      this.countDown = sec;
      const time = setInterval(()=> {
        this.countDown --;
        dt = new Date();
        if(dt.getTime() >= endDt.getTime()){
          clearInterval(time);
          this.countFinished();
        }
      }, 1000);
    },
    countFinished: function() {
      this.dialogCountDownFlag = !this.dialogCountDownFlag;
      this.modalTypingFlag = !this.modalTypingFlag;
      this.correctCount = 0;
      this.missCount = 0;
      this.charIndex = 0;
      this.startTime = performance.now();
      this.initTyping();
    },
    initTyping: function() {
      this.inputField = "";
      this.displayWord = this.typingWords.shift().word;
    },
    judgeTyping: function(event) {
      if(this.displayWord.charAt(this.charIndex) == event.key) {
        this.charIndex ++;
        this.correctCount ++;
      } else if(event.key == "Backspace") {
        this.missCount ++;
      } 
    },
    nextWord: function() {
      if(this.typingWords == 0 && this.displayWord.length == this.charIndex){
        this.finishTyping();
      }else if(this.displayWord.length == this.charIndex) {
          this.charIndex = 0
          this.initTyping();
      }
    },
    finishTyping: function() {
      this.modalTypingFlag = !this.modalTypingFlag
      this.dialogResultFlag = !this.dialogResultFlag
      this.finishTime = performance.now();
      this.typingTime = ( (this.finishTime - this.startTime) / 1000 ).toFixed(2)
      this.correctRate = ( (this.correctCount - this.missCount) / this.correctCount ).toFixed(4)
      this.typingScore = Math.round(this.correctCount * 60 / this.typingTime * Math.pow(this.correctRate, 2));
      axios.post(`/api/books/${this.id}/score`, {typing_score: this.typingScore, typing_time: this.typingTime})
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

button {
  transition: all .2s ease;
}

button:hover {
  transform: scale(1.15, 1.15);
}

#wrapper {
  background-color: rgb(189, 255, 198);
}

.v-input {
  padding: 0 25px;
}
</style>