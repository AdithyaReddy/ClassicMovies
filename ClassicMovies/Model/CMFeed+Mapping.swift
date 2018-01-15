//
//  CMFeed+Mapping.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 15/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import Foundation

extension CMFeed {
    class func createMapping(store: RKManagedObjectStore) -> RKEntityMapping {
        let mapping = RKEntityMapping(forEntityForName: CMFeed.mr_entityName(),
                                      in: store)
        let attributesDictionary: [String:String] = [
            "page": "currentPageNumber",
            "total_results": "totalResultsCount",
            "total_pages": "totalPagesCount"
        ]
        mapping?.addAttributeMappings(from: attributesDictionary)
        mapping?.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "results",
                                                          toKeyPath: "results",
                                                          with: CMMovie.createMapping(store: store)))
        
        return mapping!
    }
}
