//
//  SavedWordsStore.swift
//  Dictionary
//
//  Created by Robert Xiao on 2023-07-15.
//

import Foundation

class SavedWordsStore: ObservableObject {
    @Published var savedWords: [SavedWord] = []
    
    func getFileURL() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first!.appendingPathComponent("SavedWords.data")
    }
    
    func load() async throws {
        let task = Task {
            let url = getFileURL()
            guard let data = try? Data(contentsOf: url) else {
                return [SavedWord]()
            }
            return try JSONDecoder().decode([SavedWord].self, from: data)
        }
        self.savedWords = try await task.value
    }
    
    func save() async throws {
        let task = Task {
            let url = getFileURL()
            try JSONEncoder().encode(savedWords).write(to: url)
        }
        _ = try await task.value
    }
}
