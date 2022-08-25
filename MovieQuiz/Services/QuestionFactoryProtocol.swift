//  Created by Gospodi on 25.08.2022.


import Foundation

protocol QuestionFactoryProtocol {
    func requestNextQuestion(completion: (QuizQuestion?) -> Void)
}
