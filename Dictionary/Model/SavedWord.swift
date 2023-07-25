//
//  SavedWord.swift
//  Dictionary
//
//  Created by Robert Xiao on 2023-07-13.
//

import Foundation
import UserNotifications

enum TestResult {
    case remember, forgot
}

enum ReminderPhase : Codable {
    case reminderDate(Date), learned
}

struct SavedWord : Codable, Identifiable {
    var id: String {
        word
    }
    
    var savedDate: Date = Date()
    var reminderPhase: ReminderPhase = .reminderDate(Date(timeIntervalSinceNow: memoryStages[0]))
    
    let word: String
    let definition: String
    let detailedDefinition: String
    let examples: String
    let translation: String
    
    var memoryStage: Int = 0
    
    static var memoryStages: [TimeInterval] = [5*60*60, 24*60*60, 3*24*60*60, 7*24*60*60, 30*24*60*60]
    
    var reminderPhaseDescription: String {
        switch reminderPhase {
        case .reminderDate(let date):
            return date.formatted(
                Date.FormatStyle()
                    .month(.abbreviated)
                    .day(.twoDigits)
                    .hour(.defaultDigits(amPM: .abbreviated))
                )
        case .learned:
            return "learned"
        }
    }
    
    mutating func changeReminderDate(testResult:TestResult){
        
        if case .remember = testResult {
            memoryStage += 1
            if memoryStage > 4 {
                reminderPhase = .learned
            }
            
            
        }
        if case .reminderDate = reminderPhase {
            let reminderDate = Date(timeIntervalSinceNow: SavedWord.memoryStages[memoryStage])
            reminderPhase = .reminderDate(reminderDate)
            scheduleNotification()
        }
        
    }
    
    func scheduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Do you still remember \(word)?"
        content.sound = UNNotificationSound.default
        
        /// reschedule review notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: SavedWord.memoryStages[memoryStage], repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        print("in schedule Notification")
    }
}
