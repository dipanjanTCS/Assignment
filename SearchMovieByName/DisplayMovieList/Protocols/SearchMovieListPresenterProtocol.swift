//
//  SearchMovieListPresenterProtocol.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation
import UIKit

protocol SearchMovieListPresenterProtocol: AnyObject {
    init(fromMovieNameValidator: SearchedMovieNameValidatorProtocol, webService: SearchMovieNameWebServiceProtocol, delegate: SearchMovieNameViewDelegateProtocol)
    func processSearchedMovieName(with movieName: String)
    func rownumbers() -> Int
    func prepareCell(for tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func selectedMovieDetails(for indexPathRow: Int) -> SelectedMovieDetailModel
}

