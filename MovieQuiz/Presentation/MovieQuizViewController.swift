import UIKit

final class MovieQuizViewController: UIViewController {
    private var currentQuestionIndex: Int = 0
    private let questionsAmount: Int = 10
    private let questionFactory: QuestionFactory = QuestionFactory()
    private var currentQuestion: QuizQuestion?
    
    private var score = 0
    private var totalScore = 0
    private var quizSum: Int = 0
    private var averageAccuracy: Float = 0
    private var bestQuizResult = (score: 0, date: "")
    private var currentDate: String { Date().dateTimeString }

    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var quizQuestionLabel: UILabel!
    @IBOutlet private var quizQuestionLabel: UILabel!
    @IBOutlet private weak var yesAnswerButton: UIButton!
    @IBOutlet private weak var noAnswerButton: UIButton!
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        let quiz = convert(model: questions[currentQuestionIndex])
        showQuestion(quiz: quiz)
    }
    // MARK: - Обработка ответа от пользователя
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        toggleAnswerButtons()
        let result = questions[currentQuestionIndex].correctAnswer == true
        if result {
            score += 1
        }
        showAnswerResult(isCorrect: result)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showNextQuestionOrResults()
            self.toggleAnswerButtons()
        }
    }

    @IBAction private func noButtonClicked(_ sender: UIButton) {toggleAnswerButtons()
        let result = questions[currentQuestionIndex].correctAnswer == false
        if result {
            score += 1
        }
        showAnswerResult(isCorrect: result)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showNextQuestionOrResults()
            self.toggleAnswerButtons()
        }
    }

    // MARK: - модели данных для вьюшек
    

    

    private struct AnswerResultsViewModel {
        let answerResult: Bool
    }
    // MARK: - функции, которые будут показывать вью модели на экране
    private func showQuestion(quiz step: QuizStepViewModel) {
        posterImageView.image = step.image
        textLabel.text = step.questionText
        counterLabel.text = step.questionNumber
    }
    // MARK: - функция конвертирования данных для первой вью модели
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let step = QuizStepViewModel(
            image: model.imageName,
            questionText: model.questionText,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)"
        )
        return step
    }
    // MARK: - Функция для подсветки корректности результата ответа
    private func showAnswerResult(isCorrect: Bool) {
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.borderWidth = 8
        posterImageView.layer.cornerRadius = 20
        posterImageView.layer.borderColor = UIColor(named: isCorrect ? "green" : "red")?.cgColor
    }

    private func toggleAnswerButtons() {
        noAnswerButton.isEnabled.toggle()
        yesAnswerButton.isEnabled.toggle()
    }
    // MARK: - Показываем следующий шаг
    private func showNextQuestionOrResults() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            let quiz = convert(model: questions[currentQuestionIndex])
            posterImageView.layer.borderWidth = 0
            showQuestion(quiz: quiz)
        } else {
            quizSum += 1
            totalScore += score
            averageAccuracy = Float(totalScore * 1000 / (questions.count * quizSum)) / 10
            let title = score == questions.count ? "Поздравляем!" : "Этот раунд окончен!"
            showResults(quiz: QuizResultsViewModel(
                title: title,
                textResult: """
                Ваш результат: \(score)/\(questions.count)
                Количество сыгранных квизов: \(quizSum)
                Средняя точность: \(averageAccuracy)%
                """,
                buttonText: "Сыграть еще раз"))
        }
    }

    // MARK: - Показываем результат
    private func showResults(quiz step: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: step.title,
            message: step.textResult,
            preferredStyle: .alert // preferredStyle может быть .alert или .actionSheet
        )
        let action = UIAlertAction(title: step.buttonText, style: .default) { _ in
            self.startNewRound()
        }
        alert.addAction(action) // добавляем в алерт кнопки
        self.present(alert, animated: true, completion: nil) // показываем всплывающее окно
    }
    private func startNewRound() {
        posterImageView.layer.borderColor = nil
        currentQuestionIndex = 0
        score = 0
        let quiz = convert(model: questions[currentQuestionIndex])
        showQuestion(quiz: quiz)
    }
}
