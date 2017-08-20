//
//  newQuestions .swift
//  TrueFalseStarter
//
//  Created by Ryan Clark on 20/08/2017.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import GameKit

// Struct to shape the new questions
struct Questions {
    let questions: String
    let answer: [Int: String]
    let correctAnswer: Int
}

// Question data
let newQuestions: [Questions] = [
    Questions(questions: "What year was the iphone released?", answer: [1: "2006", 2: "2007", 3: "2008", 4: "2009"], correctAnswer: 2),
    Questions(questions: "Of what is Mac the abbreviated name?", answer: [1: "Macintosh", 2: "Operating system", 3: "Master area control", 4: "Master access communication"], correctAnswer: 1),
    Questions(questions: "When was the ipad released?", answer: [1: "2008", 2: "2009", 3: "2010", 4: "2011"], correctAnswer: 2),
    Questions(questions: "Who founded Apple inc?", answer: [1: "Steve Wazniaki", 2: "Johnny Ive", 3: "Steve Jobs", 4: "Steve Correll"], correctAnswer: 3),
    Questions(questions: "How many generations of iphone have there been?", answer: [1: "6", 2: "8", 3: "10", 4: "12"], correctAnswer: 3),
    Questions(questions: "Who is the current CEO of Apple?", answer: [1: "Tim Jobs", 2: "Tim Clark", 3: "Tim Beltcher", 4: "Tim Cook"], correctAnswer: 4),
    Questions(questions: "How many Apple stores are there across the world?", answer: [1: "380", 2: "420", 3: "460", 4: "500"], correctAnswer: 3),
    Questions(questions: "How many people do Apple employee in the US?", answer: [1: "1 million", 2: "1.5 million", 3: "2 million", 4: "2.5 million"], correctAnswer: 3)
]

// Generating a set based on questions 
var roundQuestions = [Int]()
var questionIndex = 0

func generateRoundQuestions() {
    var i = 0
    
    while i < newQuestions.count {
        roundQuestions.append(i)
        i += 1
    }
}

// Chooses a question inex and temporarily removes it 
func nextQuestion() {
    questionIndex = roundQuestions.remove(at: GKRandomSource.sharedRandom().nextInt(upperBound: roundQuestions.count))
}
