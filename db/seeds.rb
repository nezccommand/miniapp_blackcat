questions = [
  {
    content: "1問目です",
    explanation: "全て室内の写真なので少し難しいです。正解の写真は、よく見ると毛並みが少し違います。",
    correct_image: "choice1_4.jpg"
  },
  {
    content: "2問目です",
    explanation: "こむちゃんはビビりなので外に出ることができません。",
    correct_image: "choice2_2.jpg"
  },
  {
    content: "3問目です",
    explanation: "もう1枚子猫の写真がありましたが、そちらは生まれたての頃のこむちゃんの写真です。",
    correct_image: "choice3_3.jpg"
  }
]

questions = questions.map do |q|
  Question.find_or_create_by(content: q[:content]) do |question|
    question.explanation = q[:explanation]
    question.correct_image = q[:correct_image]
  end
end

difficult_questions = [
  {
    content: "1問目です",
    explanation: "ほぼ背景が一緒に見える激ムズ問題です。こむちゃんは部分的に白い毛が生えているのが特徴です。",
    correct_image: "choice4_1.jpg"
  },
  {
    content: "2問目です",
    explanation: "違う猫もだいぶ似てます。こむちゃんもたまにこんな顔してます。",
    correct_image: "choice5_4.jpg"
  },
  {
    content: "3問目です",
    explanation: "今回は全部こむちゃんです！かわいいですね🐈",
    correct_image: "all_komcat.jpg"
  }
]

difficult_questions = difficult_questions.map do |q|
  DifficultQuestion.find_or_create_by(content: q[:content]) do |question|
    question.explanation = q[:explanation]
    question.correct_image = q[:correct_image]
  end
end

easy_questions = [
  {
    content: "1問目です",
    explanation: "こむちゃんはハチワレさんではありません。でもハチワレさんにも憧れています。",
    correct_image: "choice7_1.jpg"
  },
  {
    content: "2問目です",
    explanation: "一見難しい問題ですが、トップページのスライドがヒントです！",
    correct_image: "choice8_2.jpg"
  },
  {
    content: "3問目です",
    explanation: "万が一こむちゃんが外に出て海を見ていたら、そのまま水の中にドボンしないか心配です。",
    correct_image: "choice9_2.jpg"
  }
]

easy_questions = easy_questions.map do |q|
  EasyQuestion.find_or_create_by(content: q[:content]) do |question|
    question.explanation = q[:explanation]
    question.correct_image = q[:correct_image]
  end
end


choices = [
  { question: questions[0], image: "choice1_1.jpg", correct: false },
  { question: questions[0], image: "choice1_2.jpg", correct: false },
  { question: questions[0], image: "choice1_3.jpg", correct: false },
  { question: questions[0], image: "choice1_4.jpg", correct: true },

  { question: questions[1], image: "choice2_1.jpg", correct: false },
  { question: questions[1], image: "choice2_2.jpg", correct: true },
  { question: questions[1], image: "choice2_3.jpg", correct: false },
  { question: questions[1], image: "choice2_4.jpg", correct: false },

  { question: questions[2], image: "choice3_1.jpg", correct: false },
  { question: questions[2], image: "choice3_2.jpg", correct: false },
  { question: questions[2], image: "choice3_3.jpg", correct: true },
  { question: questions[2], image: "choice3_4.jpg", correct: false }
]

choices.each do |choice|
  Choice.find_or_create_by(question: choice[:question], image: choice[:image]) do |c|
    c.correct = choice[:correct]
  end
end

dif_choices = [
  { difficult_question: difficult_questions[0], image: "choice4_1.jpg", correct: true },
  { difficult_question: difficult_questions[0], image: "choice4_2.jpg", correct: false },
  { difficult_question: difficult_questions[0], image: "choice4_3.jpg", correct: false },
  { difficult_question: difficult_questions[0], image: "choice4_4.jpg", correct: false },
  { difficult_question: difficult_questions[0], image: "choice4_5.jpg", correct: false },
  { difficult_question: difficult_questions[0], image: "all_komcat.jpg", correct: false },

  { difficult_question: difficult_questions[1], image: "choice5_1.jpg", correct: false },
  { difficult_question: difficult_questions[1], image: "choice5_2.jpg", correct: false },
  { difficult_question: difficult_questions[1], image: "choice5_3.jpg", correct: false },
  { difficult_question: difficult_questions[1], image: "choice5_4.jpg", correct: true },
  { difficult_question: difficult_questions[1], image: "choice5_5.jpg", correct: false },
  { difficult_question: difficult_questions[1], image: "all_komcat.jpg", correct: false },

  { difficult_question: difficult_questions[2], image: "choice6_1.jpg", correct: false },
  { difficult_question: difficult_questions[2], image: "choice6_2.jpg", correct: false },
  { difficult_question: difficult_questions[2], image: "choice6_3.jpg", correct: false },
  { difficult_question: difficult_questions[2], image: "choice6_4.jpg", correct: false },
  { difficult_question: difficult_questions[2], image: "choice6_5.jpg", correct: false },
  { difficult_question: difficult_questions[2], image: "all_komcat.jpg", correct: true }
]

dif_choices.each do |choice|
  c = Choice.find_or_create_by(difficult_question_id: choice[:difficult_question].id, image: choice[:image]) do |new_choice|
    new_choice.correct = choice[:correct]
  end
end

easy_choices = [
  { easy_question: easy_questions[0], image: "choice7_1.jpg", correct: true },
  { easy_question: easy_questions[0], image: "choice7_2.jpg", correct: false },


  { easy_question: easy_questions[1], image: "choice8_1.jpg", correct: false },
  { easy_question: easy_questions[1], image: "choice8_2.jpg", correct: true },


  { easy_question: easy_questions[2], image: "choice9_1.jpg", correct: false },
  { easy_question: easy_questions[2], image: "choice9_2.jpg", correct: true }
]

easy_choices.each do |choice|
  c = Choice.find_or_create_by(easy_question_id: choice[:easy_question].id, image: choice[:image]) do |new_choice|
    new_choice.correct = choice[:correct]
  end
end

puts "✅問題が登録されました"
