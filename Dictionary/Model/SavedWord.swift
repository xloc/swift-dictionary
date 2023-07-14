//
//  SavedWord.swift
//  Dictionary
//
//  Created by Robert Xiao on 2023-07-13.
//

import Foundation

let memoryStages: [TimeInterval] = [5*60*60, 24*60*60, 3*24*60*60, 7*24*60*60, 30*24*60*60]

enum TestResult {
    case remember, forgot
}

enum ReminderPhase {
    case reminderDate(Date), learned
}

struct SavedWord {
    let savedDate: Date
    var reminderPhase: ReminderPhase
    
    let word: String
    let definition: String
    let detailedDefintion: String
    let examples: String
    let translation: String
    
    var memoryStage: Int = 0
    
    mutating func changeReminderDate(testResult:TestResult){
        
        if case .remember = testResult {
            memoryStage += 1
            if memoryStage > 4 {
                reminderPhase = .learned
            }
        }
        if case .reminderDate = reminderPhase {
            let reminderDate = Date(timeIntervalSinceNow: memoryStages[memoryStage])
            reminderPhase = .reminderDate(reminderDate)
        }
        
//        switch testResult{
//        case .remember:
//            memoryStage += 1
//            if memoryStage > 4 {
//                reminderPhase = .learned
//            }
//
//        case .forgot:
//            break
//        }
//        switch reminderPhase{
//        case .reminderDate:
//            var reminderDate = Date(timeIntervalSinceNow: memoryStages[memoryStage])
//            reminderPhase = .reminderDate(reminderDate)
//        case .learned:
//            break
//        }
    }
}