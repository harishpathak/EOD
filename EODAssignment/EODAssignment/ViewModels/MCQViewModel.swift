//
//  MCQViewModel.swift
//  EODAssignment
//
//  Created by Harish Pathak on 16/08/18.
//  Copyright © 2018 CRMNEXT. All rights reserved.
//

import Foundation

class MCQViewModel {
    
    var modelQuestion: Box<Questions> = Box(v: Questions())
    var selectedAnswers: [IndexPath] = []
    var checkAnswers: Bool = false
    
    func fillModel() -> Void {
        let url = "https://api.myjson.com/bins/17lhn8"
        
        Network.callAPI(url: url) { (data) in
            
            self.modelQuestion.value = try! JSONDecoder().decode(Questions.self, from: data)
            
        }
        
    }
    
    func numberOfQuestions()->Int{
        return self.modelQuestion.value.questions.count
    }
    
    func numberOfOptions(questionIndex: Int)->Int{
        return self.modelQuestion.value.questions[questionIndex].options.count
    }
    
    func optionDataForQuestion(questionIndex: Int, optionIndex: Int)->Option{
        return self.modelQuestion.value.questions[questionIndex].options[optionIndex]
    }
    
    func questionText(questionIndex: Int) -> String {
        return "Q\(questionIndex+1). " + self.modelQuestion.value.questions[questionIndex].text
    }
    
    func resetQuestions()  {
        self.checkAnswers = false
        self.selectedAnswers.removeAll()
    }
    
    func giveAnswer(path: IndexPath) {
        self.selectedAnswers = self.selectedAnswers.filter { (selected) -> Bool in
            selected.section != path.section
        }
        
        self.selectedAnswers.append(path)
    }
    
}
