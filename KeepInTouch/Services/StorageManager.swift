//
//  StorageManager.swift
//  KeepInTouch
//
//  Created by ikorobov on 28.02.2023.
//

import Foundation
import SwiftUI

class StorageManager: ObservableObject {
    
    @Published var persons: [Person] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
    }
    
    static func load() async throws -> [Person] {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .success(let person):
                        continuation.resume(returning: person)
                }
            }
        }
    }
    
    static func load(completion: @escaping(Result<[Person], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let persons = try JSONDecoder().decode([Person].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(persons))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(persons: [Person]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(persons: persons) { result in
                switch result {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .success(let personsSaved):
                        continuation.resume(returning: personsSaved)
                }
            }
        }
    }
    
    static func save(persons: [Person], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(persons)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(persons.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
