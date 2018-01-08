//
//  MovieDetailsOperationProtocol.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 08/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

protocol MovieDetailsOperationProtocol {
    func getMovieCompleteDetails(onSuccess successBlock:@escaping (()-> Void), onError errorBlock:@escaping ((NSError, _ statusCode : Int)-> Void))
}
extension MovieFeedOperation: MovieFeedOperationProtocol {
    func getMovieFeed(onSuccess successBlock: @escaping (() -> Void), onError errorBlock: @escaping ((NSError, Int) -> Void)) {
        //
    }
}
