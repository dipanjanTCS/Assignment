//
//  MockMovieNameValidator.swift
//  SearchMovieByNameTests
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation
@testable import SearchMovieByName
class MockMovieNameValidator : SearchedMovieNameValidatorProtocol {
    var isMovieNameValid = false
    
    func isSearchMovieNameValid(movieName name : String) -> Bool{
        if name.count >= 3 {
            isMovieNameValid = true
        }
        return isMovieNameValid
    }
}



