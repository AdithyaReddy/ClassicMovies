//
//  MovieFeedOperationProtocol.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 08/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

protocol MovieFeedOperationProtocol {
    func getMovieFeed(onSuccess successBlock:@escaping ((_ feed: CMFeed)-> Void), onError errorBlock:@escaping ((NSError, _ statusCode : Int)-> Void))
}
