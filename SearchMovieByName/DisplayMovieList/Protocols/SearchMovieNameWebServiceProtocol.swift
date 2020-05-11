//
//  SearchMovieNameWebServiceProtocol.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation

protocol SearchMovieNameWebServiceProtocol {
    func fetchMovieList<T>(using resource : Resource<T>?,completion: @escaping (Result<T,SearchMovieErrors>) -> ())
}
