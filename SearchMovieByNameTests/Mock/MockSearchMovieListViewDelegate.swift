//
//  MockSearchMovieListDelegate.swift
//  SearchMovieByNameTests
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation
import XCTest
@testable import SearchMovieByName

class MockSearchMovieListViewDelegate: SearchMovieNameViewDelegateProtocol {
    var expecatation: XCTestExpectation?
    var successfulyFetchedMovieListCounter = 0
    var errorHandlerCounter = 0
    var searchError: SearchMovieErrors?
    
    func successfulyFetchedMovieList() {
        self.successfulyFetchedMovieListCounter += 1
        self.expecatation?.fulfill()
    }
    
    func errorHandler(with error: SearchMovieErrors) {
        self.searchError = error
        self.errorHandlerCounter += 1
        self.expecatation?.fulfill()
    }   
}


