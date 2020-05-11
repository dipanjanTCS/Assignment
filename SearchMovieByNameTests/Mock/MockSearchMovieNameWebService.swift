//
//  MockSearchMovieNameWebService.swift
//  SearchMovieByNameTests
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation
@testable import SearchMovieByName

class MockSearchMovieNameWebService : SearchMovieNameWebServiceProtocol{
    var isFetchMovieListGetCalled = false
    var shouldFailedWithError = false
    var shouldSentFailResponse = false
    let successStubMovieList = SearchMovieListResponseModel(searchResult: [SelectedMovieDetailModel(movieTitle: "Iron Man", movieReleaseYear: "2008", movieIMDBid: "tt0371746", movieType: "movie", moviePosterUrl: "https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_SX300.jpg")], totalResults: "9951", response: .True)
    let failureStublist = SearchMovieListResponseModel(searchResult: nil, totalResults: "0", response: .False)
    
    
    func fetchMovieList<T>(using resource: Resource<T>?, completion: @escaping (Result<T, SearchMovieErrors>) -> ()) where T : Decodable {
        isFetchMovieListGetCalled = true
        
        
        
        if(shouldFailedWithError){
            completion(.failure(.movieNotFound(description: "MovieNotFound")))
        }else if(shouldSentFailResponse){
            
            completion(.success(failureStublist as! T))
            
        }else{
            completion(.success(successStubMovieList as! T))
        }
    }
    
    
}

extension MockSearchMovieNameWebService {
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}

