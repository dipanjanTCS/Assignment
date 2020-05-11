//
//  MovieListViewControllerTest.swift
//  SearchMovieByNameTests
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import XCTest
@testable import SearchMovieByName
class MovieListViewControllerTest: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: MovieListViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "MovieListViewController") as MovieListViewController
        sut.loadViewIfNeeded()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        sut = nil
    }
    
    func testMovieListViewController_WhenCreated_SearchBarTextShouldEmpty() throws{
        //Arrange
        let movieNameSearchBar = try XCTUnwrap(sut.movieNameSearchBar,"The MovieNameSearchBar is not connected to an IBOutlet")
        //Act
        
        //Assert
        
        XCTAssertEqual(movieNameSearchBar.searchTextField.text,"", "Movie SearchBar was not empty when ViewController firstime loaded")
        XCTAssertNotNil(movieNameSearchBar.delegate,"Movie SearchBar delegate was not connecte")
    }
    
    func testMovieListViewController_WhenSearcButtonPressed_FetchMovieListcalled(){
        //Arrange
        let mockSearchMovieValidator = MockMovieNameValidator()
        let mockSearchWebService = MockSearchMovieNameWebService()
        let mockSearchMovieNameViewDelegate = MockSearchMovieListViewDelegate()
        
        let mockSearchMovieListPresnter = MockSearchMovieListPresnter(fromMovieNameValidator: mockSearchMovieValidator, webService: mockSearchWebService, delegate: mockSearchMovieNameViewDelegate)
        sut.searchMovieListPresenter = mockSearchMovieListPresnter
        
        //Act
        
        sut.movieNameSearchBar.delegate?.searchBarSearchButtonClicked?(sut.movieNameSearchBar)
        //Assert
        XCTAssertTrue(mockSearchMovieListPresnter.processSearchedMovieNameCalled,"The processSearchedMovieName() method does not get called")
        
        
        
    }
    
}
