import UIKit

final class MovieQuizViewController: UIViewController {
    @IBOutlet private weak var quizCounterLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var quizQuestionLabel: UILabel!
    @IBOutlet private weak var yesAnswerButton: UIButton!
    @IBOutlet private weak var noAnswerButton: UIButton!

    private let questionFactory: QuestionFactoryProtocol = QuestionFactory()

    private var quizState = QuizResultsViewModel(maxCorrectAnswers: 10)
    private var currentQuestion: QuizQuestion?
    private var currentQuestionIndex: Int = 0
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImageView.layer.masksToBounds = true

        showCurrentQuizStep()
    }

    private func showCurrentQuizStep() {
        if let firstQuestion = questionFactory.requestNextQuestion() {
            currentQuestion = firstQuestion
            let stepModel = convert(model: firstQuestion)
            show(quiz: stepModel)
        }
    }

    private func show(quiz step: QuizStepViewModel) {
        UIView.animate(withDuration: 0.1) {
            self.posterImageView.image = step.image
            self.quizQuestionLabel.text = step.questionTextNext
            self.quizCounterLabel.text = "\(self.currentQuestionIndex + 1)/\(self.quizState.maxCorrectAnswers)"
        }
    }

    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.viewModel.title,
            message: result.viewModel.resultMessage,
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in self?.restart()})
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    private func restart() {
        quizState.counterCorrectAnswers = 0
        currentQuestionIndex = 0
        showCurrentQuizStep()
    }

    private func showNextQuestionOrResults() {
        [yesAnswerButton, noAnswerButton].forEach { $0?.isEnabled = true }
        if currentQuestionIndex == quizState.maxCorrectAnswers - 1 {
            quizState.results.append(quizState.counterCorrectAnswers)
            quizState.quizCounter += 1
            if quizState.recordCorrectAnswers < quizState.counterCorrectAnswers {
                quizState.recordCorrectAnswers = quizState.counterCorrectAnswers
                quizState.recordDate = Date()
            }
            show(quiz: quizState)
        } else {
            currentQuestionIndex += 1
            showCurrentQuizStep()
        }
    }

    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            quizState.counterCorrectAnswers += 1
        }
        [yesAnswerButton, noAnswerButton].forEach { $0?.isEnabled = false }
        posterImageView.layer.borderWidth = 8
        posterImageView.layer.borderColor = (isCorrect ? UIColor.green : UIColor.red).cgColor

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.posterImageView.layer.borderWidth = 0
            self.posterImageView.layer.borderColor = UIColor.clear.cgColor
            self.showNextQuestionOrResults()
        }
    }

    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(named: model.imageName) ?? .remove,
            questionTextNext: model.questionText)
    }

    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = true
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }

    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = false
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
}
