//
//  Questions.swift
//  EODAssignment
//
//  Created by Harish Pathak on 16/08/18.
//  Copyright © 2018 CRMNEXT. All rights reserved.

import Foundation

//MARK: - Questions
struct Questions : Codable {
    
    var questions : [Question] = [Question]()
    
    enum CodingKeys: String, CodingKey {
        case questions = "questions"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        questions = (try values.decodeIfPresent([Question].self, forKey: .questions))!
    }
    
    init() {
        
    }
    
}


struct Question : Codable {
    
    var options : [Option] = []
    var text : String = ""
    
    enum CodingKeys: String, CodingKey {
        case options = "options"
        case text = "text"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        options = (try values.decodeIfPresent([Option].self, forKey: .options))!
        text = (try values.decodeIfPresent(String.self, forKey: .text))!
    }
    
}


struct Option : Codable {
    
    var correct : String=""
    var text : String=""
    
    enum CodingKeys: String, CodingKey {
        case correct = "correct"
        case text = "text"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        correct = (try values.decodeIfPresent(String.self, forKey: .correct))!
        text = (try values.decodeIfPresent(String.self, forKey: .text))!
    }
    
}

