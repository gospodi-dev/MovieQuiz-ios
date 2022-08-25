//  Created by Gospodi on 16.08.2022.

import Foundation

class QuestionFactory: QuestionFactoryProtocol {

    private let delegate: QuestionFactoryDelegate

    private let questions: [QuizQuestion] = [
        QuizQuestion(
            imageName: "The Godfather",
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true,
            rating: 9.2),
        QuizQuestion(
            imageName: "The Dark Knight",
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true,
            rating: 9),
        QuizQuestion(
            imageName: "Kill Bill",
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true,
            rating: 8.1),
        QuizQuestion(
            imageName: "The Avengers",
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true,
            rating: 8),
        QuizQuestion(
            imageName: "Deadpool",
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true,
            rating: 8),
        QuizQuestion(
            imageName: "The Green Knight",
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true,
            rating: 6.6),
        QuizQuestion(
            imageName: "Old",
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false,
            rating: 5.8),
        QuizQuestion(
            imageName: "The Ice Age Adventures of Buck Wild",
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false,
            rating: 4.3),
        QuizQuestion(
            imageName: "Tesla",
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false,
            rating: 5.1),
        QuizQuestion(
            imageName: "Vivarium",
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false,
            rating: 5.8)
    ]

    func requestNextQuestion() -> QuizQuestion? {
        let index = (0..<questions.count).randomElement() ?? 0
        return questions[safe: index]
    }
}
