//
//  SearchMovieNameConstants.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 10/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation

struct SearchMovieNameConstants {
    static let movieNameMinLength = 3
    static let movieMaxLength = 15
    
    static func getURLString(withMovie name: String) -> String{
        return "http://www.omdbapi.com/?s=\(name)&apikey=564727fa"
    }
}
