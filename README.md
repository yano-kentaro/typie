# README

# アプリ概要  
## What is this app?  
- ## `エンジニア初学者用の英単語タイピングアプリ`  
![sample01](https://user-images.githubusercontent.com/77100664/109389537-46606880-7950-11eb-8c35-8f229e35fe2a.png)
<br>

## Demo Page  
- URL: http://54.95.229.185/
<br>

## Persona  
- 国籍: 日本人
- `エンジニア初学者`
- 年齢: 10代後半〜30代半ば
- 自分でいくつかソースコードを書いている
- 日本語のタイピングならばそれなりに早い
- 多少は手元を見なくともタイピングを行える
- 英単語のタイピングになると途端にスピードが落ちる
- 正確にタイピング出来ているかの確認に時間がかかる
- もっと早くコードを書けるようになりたいと思っている  
<br>

## What this app can do?  
- コピー＆ペーストしたソースコードから英単語のみを抽出
- タイピングに使用する英単語に絞ってタイピング練習を行える  
![sample02](https://user-images.githubusercontent.com/77100664/109389556-54ae8480-7950-11eb-802b-7420bb2c858d.png)
<br>

## Why developed this app?  
- 英単語のタイピングには"慣れ"が必要  
    ↓↓↓  
    `タイピングにおける"慣れ"とは？`  
    ↓↓↓  
- 日本語のように、”次に打つべき文字”がパッと思い浮かぶ状態
- 一文字違っていれば違和感を感じられる状態  
    ↓↓↓  
    `効率よく"慣れ"るためには？`  
    ↓↓↓  
- プログラミングに使用する英単語に重点をおいて練習すべき  
    ↓↓↓  
    `その問題をどう作成するか？`  
    ↓↓↓  
- ソースコードから英単語を抽出すれば、それは確実にプログラミングに使用する英単語である  
    ↓↓↓  
    `既存のアプリとは何が違うのか？`  
    ↓↓↓  
- 下記の点から、それなりに英単語のタイピングに慣れている人が対象の構造になっている
- エンジニア向けのタイピングアプリはコピー＆ペーストした範囲全てが問題になる
- タイピングが遅いと１つの問題に対して相当な時間がかかる
- 進んでいる気がしない・終わる気がしないためかなりの根気が必要
- 当然ながら途中でやめるとスコアは出ない
- そもそも単語の入力に難儀しているのに、ファイル全てを書き写すのはしんどい  
    ↓↓↓  
    `それではどのようなアプリを開発したいのか？`  
    ↓↓↓  
- プログラミングに使用する英単語のタイピング練習が出来る
- ソースコードから問題を作成することが出来る
- 単語単位でタイピング練習が出来る
- スピード感をもってタイピングの練習をすることが出来る
- 途中で終わらせてもスコアを算出することが出来る  
![sample03](https://user-images.githubusercontent.com/77100664/109389425-e36ed180-794f-11eb-89ff-6e3c02aa53e5.png)
<br>


# データベース設計  
![sample04](https://user-images.githubusercontent.com/77100664/109391340-e4a4fc00-7959-11eb-8237-9ae727cfe81b.png)  
## Users Table  
- ### Columns  

|Column|Type|Option|
|-----|-----|-----|
|nickname|string|null: false|
|email|string|null: false|
|encrypted_password|string|null: false|  
<br>

- ### Association  
  - has_many :books  
<br>

## Books Table  
- ### Columns  

|Column|Type|Option|
|-----|-----|-----|
|title|string|null: false|
|color|string|null: false|
|user|references|null: false, foreign_key: true|  
<br>

- ### Association  
  - belongs_to :user
  - has_many :scores
  - has_many :book_languages
  - has_many :languages, through :book_languages
  - has_many :book_words
  - has_many :words, through :book_words  
<br>

## Scores table  
- ### Columns  

|Column|Type|Option|
|-----|-----|-----|
|typing_score|string|null: false|
|typing_time|string|null: false|
<br>

- ### Association  
  - belongs_to :book  
<br>

## Languages table
- ### Columns  

|Column|Type|Option|
|-----|-----|-----|
|name|string|null: false, unique: true|
<br>

- ### Association  
  - has_many :book_languages
  - has_many :books, through :book_languages  
<br>

## Book_languages table  
- ### Columns  

|Column|Type|Option|
|-----|-----|-----|
|book|references|null: false, foreign_key: true|
|language|references|null: false, foreign_key: true|  
<br>

- ### Association  
  - belongs_to :book
  - belongs_to :language  
<br>

## Words table  
- ### Columns  

|Column|Type|Option|
|-----|-----|-----|
|word|string|null: false, unique: true|  
<br>

- ### Association  
  - has_many :book_words
  - has_many :books, through :book_words  
<br>

## Book_words table  
- ### Columns  

|Column|Type|Option|
|-----|-----|-----|
|book|references|null: false, foreign_key: true|
|word|references|null: false, foreign_key: true|  
<br>

- ### Association  
  - belongs_to :book
  - belongs_to :word
