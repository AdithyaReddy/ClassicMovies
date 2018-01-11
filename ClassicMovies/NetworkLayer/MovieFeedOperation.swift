//
//  MovieFeedOperation.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 07/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

class MovieFeedOperation: BaseOperation, MovieFeedOperationProtocol {
    
    var path: String = ""
    var feedOperation: RKObjectRequestOperation?
    
    override init() {
        super.init()
        path = "\(NetworkConstants.discoverPopularMoviesApiPath)?api_key=\(NetworkConstants.imdbApiKey)&sort_by=popularity.desc"
        
        let feedMapping = CMFeed.createMapping(store: self.objectManager.managedObjectStore)
        
        let responseDescriptor = RKResponseDescriptor(mapping: feedMapping , method: RKRequestMethod.GET, pathPattern: NetworkConstants.discoverPopularMoviesApiPath, keyPath: "feed", statusCodes: IndexSet(integer: 200))
        self.objectManager.addResponseDescriptor(responseDescriptor)
    }
    
    func getMovieFeed(onSuccess successBlock: @escaping ((_ feed: CMFeed) -> Void), onError errorBlock: @escaping ((NSError, Int) -> Void)) {
        
        let request = self.objectManager.request(with: nil,
                                                 method: RKRequestMethod.GET, path: self.path, parameters: nil)
        
        self.feedOperation = self.objectManager.managedObjectRequestOperation(with: request! as URLRequest,
            managedObjectContext: self.objectManager.managedObjectStore.mainQueueManagedObjectContext,
            success: { (operation, result) -> Void in
            if let feed = result?.firstObject as? CMFeed {
                if let _ = feed.results?.allObjects as? [CMMovie] {
                    successBlock(feed)
                }
            }
        }, failure: { (operation, error) -> Void in
            if let error = error {
                print(error)
            }
        })
        
        
        self.feedOperation?.setWillMapDeserializedResponseBlock { (_object) -> Any? in
            var finalObject: [String: AnyObject] = [String: AnyObject]()
            finalObject["feed"] = _object as AnyObject
            return finalObject
        }
        self.feedOperation?.queuePriority = .veryHigh
        self.objectManager.enqueue(self.feedOperation)
        
    }
}
