//
//  GameManager.swift
//  EnhanceQuizStarter
//
//  Created by Lexi on 4/15/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

struct Question {
    let question: String
    let options: [String]
    let answer: String
}

class GameManager {
let questionsPerRound: Int
var questionsAsked = 0
var correctQuestions = 0
var usedNumbers: [Int] = []
var indexOfSelectedQuestion = 0

let trivia: [Question] = [
    Question(question: "Only female koalas can whistle", options: ["True", "False"], answer: "False"),
    Question(question: "Blue whales are technically whales", options: ["True", "False"], answer: "True"),
    Question(question: "Camels are cannibalistic", options: ["True", "False"], answer: "False"),
    Question(question: "All ducks are birds", options: ["True", "False"], answer: "True"),
    Question(question: "This, was the only US President to serve more than two consecutive terms", options: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answer: "Franklin D. Roosevelt"),
    Question(question: "Which of the following countries has the most residents?", options: ["Nigeria", "Russia", "Iran", "Vietnam"], answer: "Nigeria"),
    Question(question: "In what year was the United Nations founded?", options: ["1918", "1919", "1945", "1954"], answer: "1945"),
    Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", options: ["Paris", "Washington D.C.", "New York City", "Boston"], answer: "New York City"),
    Question(question: "Which nation produces the most oil?", options: ["Iran", "Iraq", "Brazil", "Canada"], answer: "Canada"),
    Question(question: "Which country has most recently won consecutive World Cups in Soccer?", options: ["Italy", "Brazil", "Argentina", "Spain"], answer: "Brazil"),
    Question(question: "Which of the following rivers is longest?", options: ["Yangtze", "Mississippi", "Congo", "Mekong"], answer: "Mississippi"),
    Question(question: "Which city is the oldest?", options: ["Mexico City", "Cape Town", "San Juan", "Sydney"], answer: "Mexico City"),
    Question(question: "Which country was the first to allow women to vote in national elections?", options: ["Poland", "United States", "Sweden", "Senegal"], answer: "Poland"),
    Question(question: "Which of these countries won the most medals in the 2012 Summer Games?", options: ["France", "Germany", "Japan", "Great Britian"], answer: "Great Britian")
]

    init(questionsPerRound: Int) {
       self.questionsPerRound = questionsPerRound
    }
    
    func checkNumber() -> Int {
   self.indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
   while usedNumbers.contains(indexOfSelectedQuestion) {
    self.indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
    }
    usedNumbers.append(indexOfSelectedQuestion)
    return indexOfSelectedQuestion
    }
}

