//
//  SearchMovieListResponseModel.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 10/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation

import Foundation

enum APIResponse: String, Codable {
    case True
    case False
}

struct SearchMovieListResponseModel: Decodable {
    var searchResult: [SelectedMovieDetailModel]?
    var totalResults: String
    var response: APIResponse
    
}

extension SearchMovieListResponseModel {
    enum CodingKeys: String, CodingKey {
        case searchResult = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }
}
