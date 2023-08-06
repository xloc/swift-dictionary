//
//  SavedWordsStore.swift
//  Dictionary
//
//  Created by Neil Fan on 2023-07-15.
//

import Foundation

struct MyDataType: Codable {
    var savedWords: [SavedWord] = []
    var reviewSchedule: [TimeInterval] = [5*60*60, 24*60*60, 3*24*60*60, 7*24*60*60, 30*24*60*60]
}

@MainActor
class SavedWordsStore: ObservableObject {
    @Published var savedWords: [SavedWord] = []
    
    init() {
        print("savedWordStore init")
    }
    
    func getFileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("SavedWords.data")
    }
    
    func load() async throws {
        let task = Task {
            let url = try getFileURL()
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(MyDataType.self, from: data)
        }
        
        var myData: MyDataType
        do {
            myData = try await task.value
        }
        catch {
            myData = MyDataType()
            print("data loading exception")
        }
        self.savedWords = myData.savedWords
        SavedWord.memoryStages = myData.reviewSchedule
    }
    
    func save() async throws {
        let task = Task {
            let url = try getFileURL()
            let myData = MyDataType(savedWords: savedWords, reviewSchedule: SavedWord.memoryStages)
            try JSONEncoder().encode(myData).write(to: url)
        }
        
        _ = try await task.value
    }
}
