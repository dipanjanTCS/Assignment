//
//  SearchMovieNameWebService.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 10/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Decodable> {
    var url: String
    var sendData: Data?
    var requestType: RequestType = .get
}

class SearchMovieNameWebService {
    
    private var urlSession: URLSession
    
    init(with urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension SearchMovieNameWebService: SearchMovieNameWebServiceProtocol {
    
    func fetchMovieList<T: Decodable>(using resource: Resource<T>?,completion: @escaping (Result<T,SearchMovieErrors>) -> ()) {
        guard let resource = resource else {
            completion(.failure(.invalidResource(description: "Sorry! Resource file is not found ")))
            return
        }
        
        guard let url = URL(string: resource.url) else {
            //TODO: Create testcase
            completion(.failure(.invalidRequestURLString(description: "Sorry! Not a valid url.")))
            return
        }
 
        self.urlSession.dataTask(with: url) { (data, response, error) in

            guard let data = data , error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.failedRequest(description: error?.localizedDescription)))
                }
                return
            }
            guard let responseData = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponseModel(description: "Sorry! The server response is not valid")))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(responseData))
            }
            
        }.resume()
    }
}
