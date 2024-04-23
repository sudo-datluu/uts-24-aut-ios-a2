//
//  ScoreController.swift
//  BubblePop
//
//  Created by David on 22/4/2024.
//

import Foundation
class ScoreController {
    private let fileName = "scores.json"
    private var scores: [ScoreModel] = [] // List of scores
    
    // Load scores from the JSON file, creating it if it doesn't exist
    func load() {
        let fileURL = getFileURL()
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            // Create an empty JSON array
            let initialData = try? JSONSerialization.data(withJSONObject: [], options: [])
            try? initialData?.write(to: fileURL)
            return
        }

        if let data = try? Data(contentsOf: fileURL) {
            if let loadedScores = try? JSONDecoder().decode([ScoreModel].self, from: data) {
                scores = loadedScores // Load existing scores
            }
        }
    }
    
    // Save a new score to the JSON file
    func save(score: ScoreModel) {
        let fileURL = getFileURL()
        
        scores.append(score) // Add the new score
        
        // Sort top scores in descending order
        scores.sort { $0.score > $1.score }
        if scores.count > 10 {
            scores = Array(scores[0..<10])
        }
        
        
        if let data = try? JSONEncoder().encode(scores) {
            try? data.write(to: fileURL) // Save updated scores to JSON
        }
    }
    
    // Return the list of scores
    func getScores() -> [ScoreModel] {
        load()
        return scores
    }
    
    // Get high score
    func getHighScore() -> String {
        return scores.count <= 0 ? "No record" : String(format: "%.1f", scores[0].score)
    }
    
    func getFileURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName) // The path to the scores JSON file
    }
}
