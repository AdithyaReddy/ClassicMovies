//
//  MovieDetailsOperationProtocol.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 08/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

internal protocol MovieDetailsOperationProtocol {
    func getMovieCompleteDetails(onSuccess successBlock:@escaping (()-> Void), onError errorBlock:@escaping ((NSError, _ statusCode : Int)-> Void))
}
