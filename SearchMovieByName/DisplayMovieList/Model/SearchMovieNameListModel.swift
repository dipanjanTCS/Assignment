//
//  SearchMovieNameListModel.swift
//  SearchMovieByName
//
//  Created by Dhiman Dutta on 10/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation

enum APIResponse : String, Codable {
    case True
    case False
}

struct SearchMovieNameListResponseModel : Decodable{
    var searchResult : [SelectedMovieDetailModel]
    var totalResults : String
    var response : APIResponse
    
}

extension SearchMovieNameListResponseModel{
    enum CodingKeys : String, CodingKey {
        case searchResult = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }
}
