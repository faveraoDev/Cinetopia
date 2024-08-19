//
//  MovieService.swift
//  Cinetopia
//
//  Created by João Victor Mantese on 26/07/24.
//

import Foundation
import Alamofire

enum MovieServiceError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

// Solução com Alamofire

struct MovieService {
    func getMovies() async throws -> [Movie] {
        let urlString = "https://my-json-server.typicode.com/alura-cursos/movie-api/movies"

        guard let url = URL(string: urlString) else {
            throw MovieServiceError.invalidURL
        }

        let request = AF.request(url)

        let data: [Movie] = try await request.responseDecodable(of: [Movie].self)

        return data
    }
}

extension DataRequest {
    func responseDecodable<T: Decodable>(of type: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            self.responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

/* Solução sem Alamofire
 
 struct MovieService {
    func getMovies() async throws -> [Movie] {
        let urlString = "http://localhost:3000/movies"
        
        guard let url = URL(string: urlString) else {
            throw MovieServiceError.invalidURL
        }
 
        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            return movies
        } catch {
            throw MovieServiceError.decodingError
        }
    }
 } */
