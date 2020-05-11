//
//  SearchMovieErrors.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 10/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation

enum SearchMovieErrors : LocalizedError, Equatable {
    
    case invalidRequestURLString(description : String)
    case invalidResponseModel(description : String)
    case invalidResource(description : String)
    case movieNotFound(description : String)
    case failedRequest(description: String?)
    case inValidMovieName(description: String)
}

extension SearchMovieErrors {
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .movieNotFound(let description) :
            return description
        case .inValidMovieName(let description):
            return description
        case .invalidRequestURLString(let description):
            return description
        case .invalidResponseModel(let description):
            return description
        case .invalidResource(let description):
            return description
        }
    }
}
