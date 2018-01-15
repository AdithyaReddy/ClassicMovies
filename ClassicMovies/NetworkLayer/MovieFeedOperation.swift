//
//  MovieFeedOperation.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 07/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

class MovieFeedOperation: BaseOperation {
    
    var path: String = ""
    var feedOperation: RKObjectRequestOperation?
    
    override init() {
        super.init()
        path = "\(NetworkConstants.discoverPopularMoviesApiPath)?api_key=\(NetworkConstants.imdbApiKey)&sort_by=popularity.desc"
        
        let feedMapping = CMFeed.createMapping(store: self.objectManager.managedObjectStore)
        
        NSManagedObjectContext.mr_default().mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let responseDescriptor = RKResponseDescriptor(mapping: feedMapping , method: RKRequestMethod.GET, pathPattern: NetworkConstants.discoverPopularMoviesApiPath, keyPath: "feed", statusCodes: IndexSet(integer: 200))
        self.objectManager.addResponseDescriptor(responseDescriptor)
    }
}

extension MovieFeedOperation: MovieFeedOperationProtocol {
    func getMovieFeed(page: Int, onSuccess successBlock: @escaping ((_ feed: CMFeed) -> Void), onError errorBlock: @escaping ((NSError, Int) -> Void)) {
        let finalPath = self.path + "&page=\(page)"
        let request = self.objectManager.request(with: nil,
                                                 method: RKRequestMethod.GET, path: finalPath, parameters: nil)
        
        self.feedOperation = self.objectManager.managedObjectRequestOperation(with: request! as URLRequest,
            managedObjectContext: NSManagedObjectContext.mr_default(),
            success: { (operation, result) -> Void in
            if let feed = result?.firstObject as? CMFeed {
                
            self.saveChangesToManagedObjectContext(NSManagedObjectContext.mr_default())
                
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
    
    func saveChangesToManagedObjectContext(_ managedObjectContext: NSManagedObjectContext?) {
        do {
            try managedObjectContext?.saveToPersistentStore()
        }
        catch {
            print(error)
        }
    }
}
