//
//  NetworkManager.swift
//  RepoWatcher
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getRepo(atUrl urlString: String) async throws -> Repository {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidRepoUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let safeResponse = response as? HTTPURLResponse, safeResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let codingData = try decoder.decode(Repository.CodingData.self, from: data)
            return codingData.repo
        } catch {
            throw NetworkError.invalidRepoData
        }
    }
    
    func downloadImageData(from urlString: String) async -> Data? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            return nil
        }
    }
}

enum NetworkError: Error {
    case invalidRepoUrl
    case invalidResponse
    case invalidRepoData
}

enum RepoURL {
    static let widgetKit = "https://api.github.com/repos/dambri/ios-widgetkit"
    static let discordBot = "https://api.github.com/repos/dambri/sagira-discord-bot"
}
