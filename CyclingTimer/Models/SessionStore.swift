//
//  SessionStore.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-02.
//

import Foundation
/*
final class SessionStore: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("session.data")
    }
    @Published var sessions: [Session] = []
    
    
    func load() {
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let data = try? Data(contentsOf: Self.fileURL) else {
                    #if DEBUG
                    DispatchQueue.main.async {
                        self?.sessions = testData
                    }
                    #endif
                    return
                }
                guard let sessions = try? JSONDecoder().decode([Session].self, from: data) else {
                    fatalError("Can't decode saved scrum data.")
                }
                DispatchQueue.main.async {
                    self?.sessions = sessions
                }
            }
        }
}
 */
