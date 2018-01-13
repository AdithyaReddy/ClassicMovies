//
//  File.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 08/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import Foundation

struct NetworkConstants {
    static let imdbApiKey: String = "cf6a0c12863c69668dcdfc95d7090bd9"
    static let discoverPopularMoviesApiPath: String = "/3/discover/movie"
    static let baseUrl: String = "https://api.themoviedb.org"
}

struct ImageConstants {
    static let IMDBImageBaseUrl: String = "https://image.tmdb.org/t/p/w500"
}

func getFullImagePath(id: String) -> String {
    return ImageConstants.IMDBImageBaseUrl + id
}
