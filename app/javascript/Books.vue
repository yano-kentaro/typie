<template>
  <v-app id="books">
    <div class="bg-img-books">

      <div class="menus">
        <v-menu offset-y transition="slide-y-transition">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" v-on="on" @click="refinedSearch" :disabled="searchDisabled">search</v-btn>
          </template>
          <v-list>
            <v-subheader>Languages</v-subheader>
            <v-list-item-group>
              <v-list-item v-for="name in languageList" :key="name.id">
                <v-list-item-title style="font-family: sans-serif; font-weight: bold;" @click="refinedSetBook(name)">{{name}}</v-list-item-title>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-menu>
        <v-btn color="success" @click="refleshSetBook" :disabled="refleshDisabled">reflesh</v-btn>
      </div>

      <v-container class="container">

        <v-row class="row" cols="12">
          <v-col class="col" md="2.4" lg="2" xl="2" v-for="indexBook in indexBooks" :key="indexBook.id">
            <v-card v-ripple class="book" hover :color="indexBook.color" dark @click='toggleShowDialog(indexBook.id)'>
              <v-card-title>{{indexBook.title}}</v-card-title>
              <v-card-subtitle># {{indexBook.language}}</v-card-subtitle>
              <v-card-title>{{`${indexBook.book_words}words`}}<br>Best: {{indexBook.score}}pt</v-card-title>
            </v-card>
          </v-col>
        </v-row>

      <v-dialog v-model="dialogShowFlag" width="500">
        <v-card>
          <v-card-title class="headline primary white--text" primary-title>
            {{showBook.title}}
          </v-card-title>
          <v-card-subtitle class="primary white--text" style="height: 30px;">
            #{{showBook.language}}
          </v-card-subtitle>
          <v-card-text>
            <v-row class="row">
              <v-spacer></v-spacer>
              <v-col class="col" md="6" lg="6" xl="6">
              <v-card-text 
              v-for="(score, index) in showBook.score"
              :key="index"
              style="text-align: end; height: 35px; font-size: 25px; font-famiry: serif; font-weight: bold;"
              > {{index + 1}} : {{score}} pt
              </v-card-text>
              </v-col>
              <v-col class="col" md="6" lg="6" xl="6">
              <v-card-text 
              v-for="(time) in showBook.time"
              :key="time.index"
              style="height: 35px; font-size: 25px; font-famiry: serif; font-weight: bold;"
              >: {{time}} s
              </v-card-text>
              </v-col>
              <v-spacer></v-spacer>
            </v-row>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn width="415" rounded  color="primary" @click="toggleTypingDialog(showBook.id)">
              <v-spacer></v-spacer><v-spacer></v-spacer><v-spacer></v-spacer><v-spacer></v-spacer><v-spacer></v-spacer><v-spacer></v-spacer>
              Typing<v-spacer></v-spacer><v-icon>mdi-keyboard-outline</v-icon>
              <v-spacer></v-spacer><v-spacer></v-spacer><v-spacer></v-spacer><v-spacer></v-spacer>
            </v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn width="120" rounded color="orange" dark @click="toggleShowDialog(showBook.id)">
              <v-spacer></v-spacer><v-spacer></v-spacer>cancel<v-spacer></v-spacer><v-icon>mdi-cancel</v-icon>
              </v-btn>
            <v-spacer></v-spacer>
            <v-btn width="120" rounded color="error" dark @click="toggleDeleteDialog(showBook.id)">
              <v-spacer></v-spacer><v-spacer></v-spacer>Delete<v-spacer></v-spacer><v-icon>mdi-delete-circle-outline</v-icon>
              </v-btn>
            <v-spacer></v-spacer>
            <v-btn @click="editBook(showBook.id)">edit</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="dialogEditFlag" width="400">
        <v-card>
          <v-card-title class="headline success white--text">
            Edit
          </v-card-title>
          <v-divider></v-divider>
          <v-text-field v-model="putTitle"></v-text-field>
          <v-text-field v-model="putName"></v-text-field>
          <div style="display: flex; justify-content: center;">
          <v-color-picker v-model="putColor"></v-color-picker>
          </div>
          <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn width="150" rounded color="orange" dark @click="toggleEditDialog">cancel</v-btn>
          <v-spacer></v-spacer>
          <v-btn width="150" rounded color="success" @click="updateBook(showBook.id)">update</v-btn>
          <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="dialogDeleteFlag" width="400">
        <v-card>
          <v-card-title class="headline error white--text" primary-title>
            Confirm
          </v-card-title>
          <v-divider></v-divider>
          <v-card-text style="margin-top: 30px;">
            <p style="text-align: center; font-size: 20px; font-weight: bold;">本当に削除しますか？</p>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn width="120" rounded color="orange" dark @click="toggleDeleteDialog(showBook.id)">
              <v-spacer></v-spacer><v-spacer></v-spacer>cancel<v-spacer></v-spacer><v-icon>mdi-cancel</v-icon>
            </v-btn>
            <v-spacer></v-spacer>
            <v-btn width="120" rounded color="error" dark @click="deleteBook(showBook.id)">
              <v-spacer></v-spacer><v-spacer></v-spacer>Delete<v-spacer></v-spacer><v-icon>mdi-delete-circle-outline</v-icon>
            </v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="dialogTypingFlag" width="500">
        <v-card>
          <v-card-title class="headline primary white--text">Typing Challenge</v-card-title>
          <v-divider></v-divider>
          <v-card-text style="font-weight: bold; font-size: 35px; text-align: center; margin-top: 20px; letter-spacing: 3px; font-family: sans-serif, serif;">Are You Ready?</v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn width="120" rounded color="orange" dark @click="toggleTypingDialog(showBook.id)">
              <v-spacer></v-spacer><v-spacer></v-spacer>cancel<v-spacer></v-spacer><v-icon>mdi-cancel</v-icon>
            </v-btn>
            <v-spacer></v-spacer>
            <v-btn width="120" rounded color="primary" @click="beginTyping(showBook.id)">
              <v-spacer></v-spacer><v-spacer></v-spacer>start<v-spacer></v-spacer><v-icon>mdi-keyboard-outline</v-icon>
            </v-btn>
            <v-spacer></v-spacer>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="modalCountDownFlag" width="400" persistent>
        <v-card>
          <v-progress-circular :size="400" width="30" color="primary" indeterminate style="font-size: 200px;">{{countDown}}</v-progress-circular>
        </v-card>
      </v-dialog>

      <v-dialog v-model="modalTypingFlag" width="500" persistent>
        <v-card style="font-family: Source Han Code JP; height: 38vh; overflow: auto;">
          <v-card-title class="headline primary white--text">{{typingWords.length + 1}} words left.</v-card-title>
          <v-card-text style="font-size: 30px; padding-top: 30px;">{{displayWord}}</v-card-text>
          <v-text-field autofocus autocomplete="off"
          v-model="inputField"
          @keydown="judgeTyping"
          @keyup="nextWord"
          height="40px" style="height: 50px; font-size: 30px;"></v-text-field>
          <v-card-actions style="display: flex; justify-content: center;">
            <v-btn width="200" rounded color="orange" dark @click="finishTyping()">
              <v-spacer></v-spacer>
              <v-icon style="transform: scale(-1, 1);">mdi-exit-run</v-icon>
              <v-spacer></v-spacer>Exit<v-spacer></v-spacer>
              <v-icon>mdi-exit-run</v-icon>
              <v-spacer></v-spacer>
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="dialogResultFlag" width="500">
        <v-card>
          <v-card-title class="headline primary white--text">Result</v-card-title>
          <div class="result">
          <v-row class="row" cols="12">
            <v-col class="col" md="6" style="text-align: right;">Correct Characters:</v-col>
            <v-col class="col" md="6">{{correctCount}} chars</v-col>
            <v-col class="col" md="6" style="text-align: right;">Miss Characters:</v-col>
            <v-col class="col" md="6">{{missCount}} chars</v-col>
            <v-col class="col" md="6" style="text-align: right;">Correct Rate:</v-col>
            <v-col class="col" md="6">{{Math.floor(correctRate * 10000) / 100}} %</v-col>
            <v-col class="col" md="6" style="text-align: right;">Clear Time:</v-col>
            <v-col class="col" md="6">{{typingTime}} s</v-col>
            <v-col class="col" md="6" style="text-align: right;">Typing Score:</v-col>
            <v-col class="col" md="6">{{typingScore}} pt</v-col>
          </v-row>
          </div>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn width="150" rounded color="orange" dark @click="toggleResultDialog()">
              <v-spacer></v-spacer><v-spacer></v-spacer>close<v-spacer></v-spacer><v-icon>mdi-cancel</v-icon><v-spacer></v-spacer>
            </v-btn>
            <v-spacer></v-spacer>
            <v-btn width="150" rounded color="primary" @click="tryAgainTyping(showBook.id)">
              <v-spacer></v-spacer>try again<v-spacer></v-spacer><v-icon>mdi-keyboard-outline</v-icon>
            </v-btn>
            <v-spacer></v-spacer>
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
      searchDisabled: false,
      refleshDisabled: true,
      dialogShowFlag: false,
      showBook: "showBook",
      bookColor: "",
      dialogEditFlag: false,
      putTitle: "",
      putName: "",
      putColor: "",
      putCode: "",
      dialogDeleteFlag: false,
      typingWords: "typingWords",
      dialogTypingFlag: false,
      modalCountDownFlag: false,
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
      languageList: [],
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
      axios.delete(`/api/books/${this.id}`)
      .then(response=> {
        this.setBook();
      });
      this.dialogDeleteFlag = !this.dialogDeleteFlag
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
      this.modalCountDownFlag = !this.modalCountDownFlag
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
      this.modalCountDownFlag = !this.modalCountDownFlag;
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
      if(this.correctCount == 0){
        this.correctRate = 0
        } else if(this.correctCount < this.missCount){
          this.correctRate = 0
        } else {
          this.correctRate = ( (this.correctCount - this.missCount) / this.correctCount ).toFixed(4)
          }
      this.typingScore = (this.correctCount * 60 / this.typingTime * Math.pow(this.correctRate, 2)).toFixed(0);
      axios.post(`/api/books/${this.id}/score`,{score: {typing_score: this.typingScore, typing_time: this.typingTime, book_id: this.showBook.id}})
      .then(response=> {
        this.setBook();
      })
    },
    toggleResultDialog: function() {
      this.dialogResultFlag = !this.dialogResultFlag
    },
    tryAgainTyping: function(id) {
      this.dialogResultFlag = !this.dialogResultFlag
      this.dialogTypingFlag = !this.dialogTypingFlag
      this.beginTyping(id);
    },
    refinedSearch: function() {
      this.setBook();
      let array = this.indexBooks.map(i => i.language)
      this.languageList = Array.from(new Set(array)).sort()
    },
    refinedSetBook: function(name) {
      this.indexBooks = this.indexBooks.filter(i => i.language === name)
      this.searchDisabled = !this.searchDisabled
      this.refleshDisabled = !this.refleshDisabled
    },
    refleshSetBook: function() {
      this.setBook();
      this.searchDisabled = !this.searchDisabled
      this.refleshDisabled = !this.refleshDisabled
    },
    toggleEditDialog: function() {
      this.dialogEditFlag = !this.dialogEditFlag
      this.dialogShowFlag = !this.dialogShowFlag
    },
    editBook: function(id) {
      axios.get(`/api/books/${id}/edit`)
      .then(response=> {
        console.log(response.data);
        this.putTitle = response.data.title
        this.putName = response.data.name
        this.putColor = response.data.color
        this.putCode = response.data.code
      });
      this.dialogEditFlag = !this.dialogEditFlag
      this.dialogShowFlag = !this.dialogShowFlag
    },
    updateBook: function(id) {
      axios.put(`/api/books/${id}`, { form: { title: this.putTitle, name: this.putName, color: this.putColor, code: this.putCode } })
      .then(response=> {
        this.setBook();
      });
      this.dialogEditFlag = !this.dialogEditFlag
      this.toggleShowDialog(id);
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
  flex-direction: column;
}

.menus {
  width: 60%;
  margin-top: 20px;
  margin-bottom: 10px;
  display: flex;
  flex-direction: row-reverse;
}

.container {
  height: 75%;
  background-color: rgba(223, 223, 223, 0.3);
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

.result {
  height: 225px;
}

.result .col {
  font-size: 25px;
  height: 30px;
}
</style>