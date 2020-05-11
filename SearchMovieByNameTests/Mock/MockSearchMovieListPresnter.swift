//
//  MockSearchMovieListPresnter.swift
//  SearchMovieByNameTests
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation
import UIKit
@testable import SearchMovieByName
class MockSearchMovieListPresnter : SearchMovieListPresenterProtocol{
    
    var processSearchedMovieNameCalled = false
    required init(fromMovieNameValidator: SearchedMovieNameValidatorProtocol, webService: SearchMovieNameWebServiceProtocol, delegate: SearchMovieNameViewDelegateProtocol) {
        //TODO
    }
    
    func processSearchedMovieName(with movieName: String) {
        self.processSearchedMovieNameCalled = true
    }
    func rownumbers() -> Int{
        return 1
    }
    func prepareCell(for tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    }
    func selectedMovieDetails(for indexPathRow : Int) -> SelectedMovieDetailModel{
        return SelectedMovieDetailModel(movieTitle: "Iron Man", movieReleaseYear: "2008", movieIMDBid: "tt0371746", movieType: "movie", moviePosterUrl: "https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_SX300.jpg")
    }
    
    
}
