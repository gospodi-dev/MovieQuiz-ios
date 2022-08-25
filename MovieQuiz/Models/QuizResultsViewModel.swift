//
//  QuizResultsStateModel.swift
//  MovieQuiz
//
//  Created by Gospodi on 25.08.2022.
//

import Foundation
import UIKit

struct QuizResultsViewModel {
    var counterCorrectAnswers: Int = 0
    var maxCorrectAnswers: Int
    var quizCounter: Int = 0
    var recordCorrectAnswers: Int = 0
    var recordDate = Date()
    var averageAccuracy: Double {
        // swiftlint:disable all
        Double(results.reduce(0, +)) / Double(maxCorrectAnswers * (results.count == 0 ? 1 : results.count)) * 100
    }

    var results: [Int] = []

    var viewModel: ViewModel {
        ViewModel(
            title: counterCorrectAnswers == maxCorrectAnswers ? "Вы победили!" : "Этот раунд окончен!",
            resultMessage:  """
        Ваш результат: \(counterCorrectAnswers)/\(maxCorrectAnswers)
        Количество сыгранных квизов: \(quizCounter)
        Рекорд: \(recordCorrectAnswers)/\(maxCorrectAnswers) (\(recordDate.dateTimeString)) 
        Средняя точность: \(averageAccuracy)%
        """
        )
    }

    struct ViewModel {
        let title: String
        let resultMessage: String
    }
}
