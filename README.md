# [どれがこむドットコム](https://doregakomudotsutokomu.onrender.com/)
[![Image from Gyazo](https://i.gyazo.com/ecb0b1cbf7fad82009f257f649075598.png)](https://gyazo.com/ecb0b1cbf7fad82009f257f649075598)

うちの猫を見てほしいがために作った簡単なクイズアプリです。
既存のクイズアプリのコードを参考にしつつ、細かい修正や見た目の部分はAIを活用しました。  
初めての制作なのでもっとスリムにコードを書けるかもしれないし、もっと良い書き方があるかもしれませんが、それについては今後の勉強に生かしていきたいと考えています。
  
## 遊び方
* トップページから「クイズスタート」ボタンを押すとクイズがスタートします。
* うちの猫(こむちゃん)ではない画像を選べば正解、**こむちゃんを選んでしまうと不正解**のクイズになります。
* マウスオーバーしている画像が浮き上がるので、それをクリックして選択すると次の問題に進みます。
* そのまま最後まで問題を回答すると(現在は3問)、リザルト画面へと遷移します。
* あなたの正答数と、問題ごとに簡単な解説が順番に表示されます。
### 【注意】
リザルト画面から問題1までのブラウザバックは解決できましたが、トップページまでブラウザバックしてから「クイズスタート」を押すと3問目に飛んでしまいます。  
これはsessionがリセットされないまま問題が始まってしまうのが原因ですが、現状治せていないので今後修正していきたいと考えています。
→25/04/09追記　クイズスタートボタンにJSのリロード処理を入れることで解決できました
  
## アクションごとの簡単なコード解説
### topアクション
topアクションはこのアプリのルートページを設定しており、サイトにアクセスするとこのアクションが呼び出されるようになっています。
  
写真をスライドとして表示させる部分にはswiperを使用していますが、今回はviewsにCDNで呼び出す形で記述しています。  
(swiperの動作設定は`app/javascript/application.js`に記述しています)
  
今回のクイズアプリではユーザー登録が必要ないため、sessionを用いてアクセスごとに問題番号(question_index)と回答(answer)を管理しています。  
(トップページが呼び出されると、問題番号が0に、回答が空にリセットされる仕組みです)
  
「クイズスタート」ボタンを押すと、`session[:question_index]`が0の1問目に移動します。  
(このボタンを押す動作でsessionをリセットできれば、ブラウザバック問題を解決できそうかなと思っています)

### showアクション
questionテーブルの全てのquestionから、`session[:question_index]`に対応した問題を呼び出しています  

### POST answerアクション
問題ページで対象の写真をクリックするとこのアクションが呼び出され、回答が記録されて次の問題に進みます。  
具体的には、`session[:answers]`に次のように記録していきます。
```
# 実際のコード
{ "question_id" => question_id, "choice_id" => choice_id, "correct" => correct }
# 記録例 回答と正誤を問題ごとに記録する
{ "question_id" => 1, "choice_id" => 1, "correct" => true/false }
{ "question_id" => 2, "choice_id" => 2, "correct" => true/false }
{ "question_id" => 3, "choice_id" => 3, "correct" => true/false }
```
これにより、session[:answers]に問題ごとの回答と正誤判定が記録され、resultアクションで呼び出せるようになっています。

ブラウザバック時に`session[:question_index]`が進んだままになっていると次の問題が呼び出されなくなってしまうので、次のコードで解決しています。  
簡単に言うと、answerアクションが呼び出された時に次の問題を取得するので、1問目の回答の後は必ず2問目に移動できるようにしています。
```
# 次の問題を取得する
next_question_index = @questions.index(@question) + 1

# 次の問題が問題数を超えた場合、リザルト画面に移動する
if next_question_index >= @questions.count
  redirect_to result_blackcat_quiz_path

# そうでない場合、sessionを更新して次の問題を取得する
else
  session[:question_index] = next_question_index
  redirect_to blackcat_quiz_path(session[:question_index])
end
```
### resultアクション
`session[:answers]`の回答状況を呼び出し、それに合わせて条件分岐で表示を変化させています。  
正解数は回答状況の中から`correct == true`の回答を数えて表示しています。
each doメソッドを用いて処理を一般化しているので、問題数が増えても柔軟に表示を変えることができます。  
(例えば4問存在する場合は、3問正解/4問中のように自動的に表示が切り替わります)

正解の画像は今回は問題文に埋め込んでいますが、choiceテーブルから`correct: true`の画像を引っ張ってくる形でもできそうです。


## 画像の呼び出し方について
今回はRailsのヘルパーを利用して、app/assets/images配下から呼び出すためのメソッドをchoiceモデルに記述しています。  
これにより、問題ページでchoice.image_pathの形で画像を呼び出せるようになります。
```
# 画像が存在する場合はその画像を呼び出し、そうでない場合はnilを返す
def image_path
  image.present? ? ActionController::Base.helpers.asset_path(image) : nil
end
```

## Q: 左上のタイトルロゴは自分で描いたのですか？
A: クリップスタジオペイントを使って10分くらいで手描きしました。
  
## 今回のミニアプリ開発で学んだこと
* 「こういうロジックにしたい」「こう修正すれば動く」というのを具体的にイメージすることの重要性を感じました。  
  →大まかな動きは既存のものを参考にできますが、細かい部分はAIへの相談も使えますが、最終的には自分で修正していく必要があります。
  
* 開発を進める中で「ここをこう変えたい」「この機能を追加したい」と考えることが増えた  
  →とりあえず手を動かすことの重要性を学びました。アイデアは手を動かすことで降ってくる機会も増えるのではないか？と感じます。

* とりあえずなにか作って世に出してみることが目標でしたが、ここからの改善や機能追加も視野に入れています。  
  →学習用兼機能試し用としてしばらく残しておくのもアリかなと思っています。
