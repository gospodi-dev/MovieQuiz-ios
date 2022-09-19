//  Created by Gospodi on 25.08.2022.


import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
