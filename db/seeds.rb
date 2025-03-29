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

# Choiceの作成
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

puts "✅問題が登録されました"
