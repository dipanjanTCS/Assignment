//
//  MovieDetailsView.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import SwiftUI

struct MovieDetailsView: View {
    let selectedMovieDetailModel : SelectedMovieDetailModel
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                DownloadedImage(with: selectedMovieDetailModel.moviePosterUrl)
                
                Text (selectedMovieDetailModel.movieTitle)
                    .padding()
                Text(selectedMovieDetailModel.movieReleaseYear)
            }.foregroundColor(Color.white)
                .padding()
            
            Spacer()
        }
    }
    
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(selectedMovieDetailModel: SelectedMovieDetailModel(movieTitle: "Iron Man", movieReleaseYear: "2008", movieIMDBid: "tt0371746", movieType: "movie", moviePosterUrl: "https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_SX300.jpg"))
    }
}
