//
//  MovieDetailPosterLoader.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailPosterLoader: ObservableObject {
    @Published var displayImage: UIImage?
    
    init(with posterUrl: String) {
        self.loadImage(with: posterUrl)
    }
    
    func loadImage(with urlString: String) {
        
        guard let url = URL(string: urlString) else {
            self.displayImage = UIImage(systemName: "photo")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data ,
                error == nil else {
                    self.displayImage = UIImage(systemName: "photo")
                    return
            }
            
            DispatchQueue.main.async {
                self.displayImage = UIImage(data: data)
            }
        }.resume()
    }  
}
