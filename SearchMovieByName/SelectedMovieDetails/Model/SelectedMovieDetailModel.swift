//
//  SelectedMovieDetailModel.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 10/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation

struct SelectedMovieDetailModel: Decodable {
    var movieTitle: String
    var movieReleaseYear: String
    var movieIMDBid: String
    var movieType: String
    var moviePosterUrl: String
}

extension SelectedMovieDetailModel {
    
    enum CodingKeys: String,CodingKey {
        case movieTitle = "Title"
        case movieReleaseYear = "Year"
        case movieIMDBid = "imdbID"
        case movieType = "Type"
        case moviePosterUrl = "Poster"
    }
}
