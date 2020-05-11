//
//  SearchMovieListViewDelegateProtocol.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation

protocol SearchMovieNameViewDelegateProtocol: AnyObject {
    func successfulyFetchedMovieList()
    func errorHandler(with error: SearchMovieErrors)
}
