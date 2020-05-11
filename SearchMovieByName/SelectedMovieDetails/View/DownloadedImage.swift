//
//  DownloadedImage.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import SwiftUI

struct DownloadedImage: View {
    @ObservedObject var movieDetailPosterLoader : MovieDetailPosterLoader
    init(with url: String) {
        self.movieDetailPosterLoader = MovieDetailPosterLoader(with: url)
    }
    var body: some View {
        if let displayImage = self.movieDetailPosterLoader.displayImage {
            return Image(uiImage: displayImage)
        }else{
            return Image(systemName: "photo")
        }
    }
}

struct DownloadedImage_Previews: PreviewProvider {
    static var previews: some View {
        DownloadedImage(with: "https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_SX300.jpg")
    }
}
