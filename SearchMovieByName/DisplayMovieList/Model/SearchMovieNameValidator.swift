//
//  SearchMovieNameValidator.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 10/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation

struct SearchMovieNameValidator: SearchedMovieNameValidatorProtocol {
    
    func isSearchMovieNameValid(movieName name: String) -> Bool {
        var returnValue = false
        if name.count >= 3 {
            returnValue = true
        }
        return returnValue
    }
}
