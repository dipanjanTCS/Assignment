//
//  MockURLProtocolForMovieList.swift
//  SearchMovieByNameTests
//
//  Created by Dipanjan Sarker on 10/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation

class MockURLProtocolForMovieList: URLProtocol {
    static var fileName: String?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        let stubResponseData = self.readLocalFile(forName: MockURLProtocolForMovieList.fileName ?? "ResponseMovieList")
        if let responseError = MockURLProtocolForMovieList.error {
            self.client?.urlProtocol(self, didFailWithError: responseError)
        }else{
            self.client?.urlProtocol(self, didLoad: stubResponseData ?? Data())
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}


extension MockURLProtocolForMovieList{
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
