//
//  BaseOperation.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 07/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import AFNetworking

public class BaseOperation: NSObject {
    
    var urlPath: String!
    
    public func initSessionManager() -> AFHTTPSessionManager {
        let manager = AFHTTPSessionManager(baseURL: URL(string: urlPath))
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        
        return manager
    }
}
