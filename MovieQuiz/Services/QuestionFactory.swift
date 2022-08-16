//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Gospodi on 16.08.2022.
//

import Foundation

class QuestionFactory {
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            imageName: UIImage(named: "The Godfather"),
            rating: 9.2,
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            imageName: UIImage(named: "The Dark Knight"),
            rating: 9,
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            imageName: UIImage(named: "Kill Bill"),
            rating: 9.2,
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            imageName: UIImage(named: "The Avengers"),
            rating: 8,
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            imageName: UIImage(named: "Deadpool"),
            rating: 8,
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            imageName: UIImage(named: "The Green Knight"),
            rating: 6.6,
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            imageName: UIImage(named: "Old"),
            rating: 5.8,
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            imageName: UIImage(named: "The Ice Age Adventures of Buck Wild"),
            rating: 4.3,
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            imageName: UIImage(named: "Tesla"),
            rating: 5.1,
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            imageName: UIImage(named: "Vivarium"),
            rating: 5.8,
            questionText: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false)
    ]

    func requestNextQuestion() -> QuizQuestion? {
        let index = (0..<questions.count).randomElement() ?? 0
        return questions[safe: index]
    }


}

// MARK: - Mock-данные
private struct QuizQuestion {
    let imageName: UIImage?
    let rating: Float
    let questionText: String
    let correctAnswer: Bool
}
