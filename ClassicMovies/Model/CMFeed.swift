//
//  CMFeed.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 09/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import Foundation

@objc(CMFeed) class CMFeed: NSManagedObject {
    @NSManaged var currentPageNumber: NSNumber?
    @NSManaged var totalResultsCount: NSNumber?
    @NSManaged var totalPagesCount: NSNumber?
    @NSManaged var results: AnyObject?
    
    class func createMapping(store: RKManagedObjectStore) -> RKEntityMapping {
        let mapping = RKEntityMapping(forEntityForName: CMFeed.mr_entityName(),
                                      in: store)
        
        let attributesDictionary: [String:String] = [
            "page": "currentPageNumber",
            "total_results": "totalResultsCount",
            "total_pages": "totalPagesCount"
        ]
        mapping?.addAttributeMappings(from: attributesDictionary)
        //let moviesRelationship = RKRelationshipMapping(fromKeyPath: "results", toKeyPath: "movies", with: CMMovie.createMapping(store: store))
        mapping?.addRelationshipMapping(withSourceKeyPath: "results", mapping: CMMovie.createMapping(store: store))
        
        return mapping!
    }
    
}
