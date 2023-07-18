//
//  SavedWordsStore.swift
//  Dictionary
//
//  Created by Robert Xiao on 2023-07-15.
//

import Foundation

@MainActor
class SavedWordsStore: ObservableObject {
    @Published var savedWords: [SavedWord] = []
    
    func getFileURL() throws -> URL {
//        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            .first!.appendingPathComponent("SavedWords.data")
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("SavedWords.data")
    }
    
    func load() async throws {
        let task = Task {
            let url = try getFileURL()
            guard let data = try? Data(contentsOf: url) else {
                return [SavedWord]()
            }
            return try JSONDecoder().decode([SavedWord].self, from: data)
        }
        self.savedWords = try await task.value
    }
    
    func save() async throws {
        let task = Task {
            let url = try getFileURL()
            try JSONEncoder().encode(savedWords).write(to: url)
        }
        _ = try await task.value
    }
}
