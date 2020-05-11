//
//  SearchMovieNameValidatorTests.swift
//  SearchMovieByNameTests
//
//  Created by Dipanjan Sarker on 10/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import XCTest
@testable import SearchMovieByName

class SearchMovieNameValidatorTests: XCTestCase {
    
    var sut: SearchMovieNameValidator!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SearchMovieNameValidator()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    // MARK:- MovieNaneValid
    func testSearchMovieNameValidator_WhenSearchForValidMovieName_ShouldReturnTrue() {
        //  Arrange
        
        //  Act
        let isMoviewNameValid = sut.isSearchMovieNameValid(movieName: "Spider")
        // Assert
        XCTAssertTrue(isMoviewNameValid,"The isSearchMovieNameValid() should have returned TRUE for a valid first name but returned FALSE")
    }
    
    // MARK:- MovieNaneNotValid
    func testSearchMovieNameValidator_WhenSearchForValidMovieName_ShouldReturnFalse() {
        //  Arrange
        
        //  Act
        let isNotMoviewNameValid = sut.isSearchMovieNameValid(movieName: "Sp")
        // Assert
        XCTAssertFalse(isNotMoviewNameValid,"The isSearchMovieNameValid() should have returned FALSE for a valid first name but returned TRUE")
    }    
}
