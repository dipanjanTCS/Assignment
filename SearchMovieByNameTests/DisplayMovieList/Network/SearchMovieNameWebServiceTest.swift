//
//  SearchMovieNameWebServiceTest.swift
//  SearchMovieByNameTests
//
//  Created by Dipanjan Sarker on 10/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import XCTest
@testable import SearchMovieByName

class SearchMovieNameWebServiceTest: XCTestCase {
    
    var sut: SearchMovieNameWebService!
    var resource: Resource<SearchMovieListResponseModel>!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocolForMovieList.self]
        let urlSession = URLSession(configuration: config)
        sut = SearchMovieNameWebService (with: urlSession)
        resource = Resource(url: SearchMovieNameConstants.getURLString(withMovie: "man"))
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        resource = nil
        MockURLProtocolForMovieList.fileName = nil
    }

    func testSearchMovieNameWebService_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        //Arrange
        //SystemUnderTest
        MockURLProtocolForMovieList.fileName = "SuccessResponseMovieList"
        let expectation = self.expectation(description: "SearchMovieName Web Service Response Expectation")
        
        //Act
        sut.fetchMovieList(using: resource) { (result) in
            switch result{
            case .success(let responseModel):
                //Assert
                XCTAssertEqual(responseModel.response, .True)
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSearchMovieNameWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        //Arrange
        //SystemUnderTest
        MockURLProtocolForMovieList.fileName = "WrongFormatResponse"
        let expectation = self.expectation(description: "The fetchMovieList() method has an expectation for a response that contains a different JSON structure")
        //Act
        sut.fetchMovieList(using: resource) { (result) in
            switch result{
            case .success(_):
                break
            case .failure(let error):
                //Assert
                XCTAssertEqual(error, .invalidResponseModel(description: "Sorry! The server response is not valid"), "The fetchMovieList() method did not return expected error")
                XCTAssertEqual(error.errorDescription, "Sorry! The server response is not valid","There is No Alert Message for invalidResponseModel")
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSearchMovieNameWebService_WhenEmptyURLStringProvided_ReturnsError() {
        // Arrange
        let expectation = self.expectation(description: "An empty request URL string expectation")
        resource.url = ""
        //Act
        sut.fetchMovieList(using: resource) { (result) in
            switch result{
            case .success(_):
                break
                
            case .failure(let error):
                //Assert
                XCTAssertEqual(error, .invalidRequestURLString(description: "Sorry! Not a valid url."), "The fetchMovieList() method did not return an expected error for an invalidRequestURLString error")
                XCTAssertEqual(error.errorDescription, "Sorry! Not a valid url.","There is No Alert Message for invalidRequestURLString")
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSearchMovieNameWebService_WhenEmptyResourceProvided_ReturnsError() {
        // Arrange
        let expectation = self.expectation(description: "An empty request URL string expectation")
        resource = nil
        //Act
        sut.fetchMovieList(using: resource) { (result) in
            switch result{
            case .success(_):
                break
            case .failure(let error):
                //Assert
                XCTAssertEqual(error, .invalidResource(description: "Sorry! Resource file is not found "), "The fetchMovieList() method did not return an expected error for an invalidResource error")
                XCTAssertEqual(error.errorDescription, "Sorry! Resource file is not found ","There is No Alert Message for invalidResource")
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSearchMovieNameWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        // Arrange
        let expectation = self.expectation(description: "A failed Request expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocolForMovieList.error = SearchMovieErrors.failedRequest(description: errorDescription)
        
        //Act
        sut.fetchMovieList(using: resource) { (result) in
            switch result{
            case .success(_):
                break
            case .failure(let error):
                //Assert
                XCTAssertEqual(error, SearchMovieErrors.failedRequest(description: errorDescription), "The fetchMovieList() method did not return an expecter error for the Failed Reques")
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 5)    
    }
}

