//
//  MovieFeedOperation.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 07/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

class MovieFeedOperation: BaseOperation {
    
}

extension MovieFeedOperation: MovieFeedOperationProtocol {
    func getMovieFeed(onSuccess successBlock: @escaping (() -> Void), onError errorBlock: @escaping ((NSError, Int) -> Void)) {
        urlPath = ackOperationDelegate?.getBaseUrl() ?? "https://www.urbanclap.com"
        let manager = super.initSessionManager()
        
        var params: [String: AnyObject] = [String: AnyObject]()
        params["transaction_id"] = transactionId as AnyObject
        
        manager.post(
            NetworkingConstants.notificationUrlPath, parameters: params, progress: { (progressValue) in
            print(progressValue)
        }, success: { (data, result) in
            print(result)
        }) { (data, error) in
            print(error)
        }
    }
}
