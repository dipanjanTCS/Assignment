//
//  SearchMovieListPresenter.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation
import UIKit

class SearchMovieListPresenter : SearchMovieListPresenterProtocol{
    private var fromMovieNameValidator : SearchedMovieNameValidatorProtocol
    private var webService : SearchMovieNameWebServiceProtocol
    private weak var delegate : SearchMovieNameViewDelegateProtocol?
    
    var movieList : [SelectedMovieDetailModel]?
    
    required init(fromMovieNameValidator : SearchedMovieNameValidatorProtocol, webService : SearchMovieNameWebServiceProtocol, delegate : SearchMovieNameViewDelegateProtocol) {
        self.fromMovieNameValidator = fromMovieNameValidator
        self.webService = webService
        self.delegate = delegate
        movieList = [SelectedMovieDetailModel]()
    }
    func processSearchedMovieName(with movieName : String){
        if !fromMovieNameValidator.isSearchMovieNameValid(movieName: movieName){
            self.delegate?.errorHandler(with: .inValidMovieName(description: "Please provide a valid Movie Name"))
            return
        }
        let resource = Resource<SearchMovieListResponseModel>(url: SearchMovieNameConstants.getURLString(withMovie: movieName))
        webService.fetchMovieList(using: resource) { (result) in
            
            switch result{
            case .success(let responseData): 
                // responseData.response == .True ? delegate.success : delegate.failure
                if (responseData.response == .True) {
                    self.movieList = responseData.searchResult
                    self.delegate?.successfulyFetchedMovieList()
                }else{
                    self.delegate?.errorHandler(with: .movieNotFound(description: "Sorry! Searched Movie Name not found."))
                }
            case .failure(let error):
                self.delegate?.errorHandler(with: error)
                
            }
            
        }
    }
    
    func rownumbers() -> Int {
        return movieList?.count ?? 0
    }
    
    func selectedMovieDetails(for indexPathRow : Int) -> SelectedMovieDetailModel{
        guard let movieListArray = self.movieList else{
            return SelectedMovieDetailModel(movieTitle: "Iron Man", movieReleaseYear: "2008", movieIMDBid: "tt0371746", movieType: "movie", moviePosterUrl: "https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_SX300.jpg")
        }
        return movieListArray[indexPathRow]
    }
    
    func prepareCell(for tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieListArray = self.movieList else{
            return tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath)
        cell.textLabel?.text = String(format: "%@ : %@", arguments: [movieListArray[indexPath.row].movieTitle,movieListArray[indexPath.row].movieReleaseYear])
        DispatchQueue.global(qos: .userInitiated).async {
            guard
                let posterUrl = URL(string: movieListArray[indexPath.row].moviePosterUrl),
                let data = try? Data(contentsOf: posterUrl)
                else {return}
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                cell.imageView?.image = image
            }
        }
        return cell
        
    }
}
