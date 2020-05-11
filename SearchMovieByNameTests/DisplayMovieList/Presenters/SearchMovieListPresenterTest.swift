//
//  SearchMovieListPresenterTest.swift
//  SearchMovieByNameTests
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import XCTest
@testable import SearchMovieByName

class SearchMovieListPresenterTest: XCTestCase {
    
    var sut: SearchMovieListPresenter!
    var mockMovieNameVAlidator: MockMovieNameValidator!
    var mockSearchMovieNameWebService: MockSearchMovieNameWebService!
    var mockSearchMovieListViewDelegate: MockSearchMovieListViewDelegate!
    let searchedMovieName = "man"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockMovieNameVAlidator = MockMovieNameValidator()
        mockSearchMovieNameWebService = MockSearchMovieNameWebService()
        mockSearchMovieListViewDelegate = MockSearchMovieListViewDelegate()
        sut = SearchMovieListPresenter(fromMovieNameValidator: mockMovieNameVAlidator, webService: mockSearchMovieNameWebService, delegate: mockSearchMovieListViewDelegate)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockMovieNameVAlidator = nil
        mockSearchMovieNameWebService = nil
        mockSearchMovieListViewDelegate = nil
        sut = nil
    }
    
    func testSearchMovieListPresenter_WhenSearchForMovieNameCheckisValidMovieName_WillVAlidateName() {
        //Arrange
        //Act
        sut.processSearchedMovieName(with: searchedMovieName)
        //Assert
        XCTAssertTrue(mockMovieNameVAlidator.isMovieNameValid, "Searched Movie name was not validated")
    }
    
    func testSearchMovieListPresenter_WhenSearchedForVAlidMovieName_fetchMovielistGetCalled() {
        //Arrange
        //Act
        sut.processSearchedMovieName(with: searchedMovieName)
        //Assert
        XCTAssertTrue(mockSearchMovieNameWebService.isFetchMovieListGetCalled,"The fetchMovielist() method was not called in the fetchMovielist class")
    }
    
    func testSearchMovieListPresenter_WhenfetchMovieListOperationSuccessful_CallSuccessViewDelegate() {
        //Arrange
        let myexpectation = expectation(description: "Expected the fetchMoviList Success Result called")
        mockSearchMovieListViewDelegate.expecatation = myexpectation
        
        //Act
        sut.processSearchedMovieName(with: searchedMovieName)
        self.wait(for: [myexpectation], timeout: 5)
        
        //Assert
        XCTAssertEqual(mockSearchMovieListViewDelegate.successfulyFetchedMovieListCounter, 1,"The successfulyFetchedMovieList() method was called more than one time")
    }
    
    func testSearchMovieListPresenter_WhenfetchMovieListOperationisNotSuccessful_CallErrorHandlerViewDelegate() {
        //Arrange
        let errorHandlerExpectation = expectation(description: "Expected the errorHandler() method to be called")
        mockSearchMovieListViewDelegate.expecatation = errorHandlerExpectation
        mockSearchMovieNameWebService.shouldFailedWithError = true
        //Act
        sut.processSearchedMovieName(with: searchedMovieName)
        self.wait(for: [errorHandlerExpectation], timeout: 5)
        //Assert
        XCTAssertEqual(mockSearchMovieListViewDelegate.errorHandlerCounter, 1, "The errorHandler() delegate method was called more than one time")
        XCTAssertEqual(mockSearchMovieListViewDelegate.successfulyFetchedMovieListCounter, 0, "The errorHandler should get called instead successfulyFetchedMovieList() get called ")
        XCTAssertNotNil(mockSearchMovieListViewDelegate.searchError,"There is no SerachError ")
    }
    
    func testSearchMovieListPresenter_WhenFalseResponseReceived_CallErrorHandlerViewDelegate() {
        //Arrange
        let errorHandlerExpectation = expectation(description: "Expected the errorHandler() method to be called")
        mockSearchMovieListViewDelegate.expecatation = errorHandlerExpectation
        mockSearchMovieNameWebService.shouldSentFailResponse = true
        //Act
        sut.processSearchedMovieName(with: searchedMovieName)
        self.wait(for: [errorHandlerExpectation], timeout: 5)
        //Assert
        XCTAssertEqual(mockSearchMovieListViewDelegate.searchError, SearchMovieErrors.movieNotFound(description: "Sorry! Searched Movie Name not found."))
        XCTAssertEqual(mockSearchMovieListViewDelegate.searchError?.errorDescription, "Sorry! Searched Movie Name not found.","No Alert Message Provided For movieNotFound")
    }
    
    func testSearchMovieListPresenter_WhenSearchedForInavalidMovieName_CallErrorHandlerViewDelegate() {
        
        //Arrange
        let errorHandlerExpectation = expectation(description: "Expected the errorHandler() method to be called")
        mockSearchMovieListViewDelegate.expecatation = errorHandlerExpectation
        mockSearchMovieNameWebService.shouldFailedWithError = true
        // Act
        sut.processSearchedMovieName(with: " ")
        self.wait(for: [errorHandlerExpectation], timeout: 5)
        //Assert
        XCTAssertEqual(mockSearchMovieListViewDelegate.searchError, SearchMovieErrors.inValidMovieName(description: "Please provide a valid Movie Name"))
        XCTAssertEqual(mockSearchMovieListViewDelegate.searchError?.errorDescription, "Please provide a valid Movie Name","No Alert Message Provided For inValidMovieName")
    }
    
    func testSearchMovieListPresenter_CountMovieList_NotZero() {
        //Arrange
        sut.movieList = nil
        //Act
        //Assert
        XCTAssertNotNil(sut.selectedMovieDetails(for: 0))
        XCTAssertEqual(sut.rownumbers(), 0,"The movieList had no item")
    }
    
    func testSearchMovieListPresenter_SelectedMovieDetailsReturn_SelectedMovieDeatilModel() {
        //Arrange
        //Act
        sut.processSearchedMovieName(with: searchedMovieName)
        let selectedMovieDetailModel = sut.selectedMovieDetails(for: 0)
        //Assert
        XCTAssertNotNil(selectedMovieDetailModel)
    }  
}
