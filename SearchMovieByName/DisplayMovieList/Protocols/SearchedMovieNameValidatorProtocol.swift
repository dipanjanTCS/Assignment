//
//  SearchedMovieNameValidatorProtocol.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation

protocol SearchedMovieNameValidatorProtocol {
    func isSearchMovieNameValid(movieName name: String) -> Bool
}
