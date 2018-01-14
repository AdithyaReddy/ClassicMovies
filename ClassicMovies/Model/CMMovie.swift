//
//  CMMovie.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 07/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit
import CoreData

@objc(CMMovie) public class CMMovie: NSManagedObject {
    @NSManaged var voteCount: NSNumber?
    @NSManaged var id: String?
    @NSManaged var voteAverage: NSDecimalNumber?
    @NSManaged var title: String?
    @NSManaged var originalTitle: String?
    @NSManaged var popularity: NSDecimalNumber?
    @NSManaged var posterImagePath: String?
    @NSManaged var originalLang: String?
    @NSManaged var backdropPath: String?
    @NSManaged var adult: NSNumber?
    @NSManaged var overview: String?
    @NSManaged var releaseDate: Date?
    
    internal lazy var itemsAvailable: [ExpandedMovieItems] = {
        var itemsAvailable: [ExpandedMovieItems] = []
        if let _ = self.overview {
            itemsAvailable.append(CMMovie.ExpandedMovieItems.Overview)
        }
        if let _ = self.originalLang {
           itemsAvailable.append(CMMovie.ExpandedMovieItems.OriginalLang)
        }
        if let _ = self.popularity {
           itemsAvailable.append(CMMovie.ExpandedMovieItems.Popularity)
        }
        return itemsAvailable
    }()
    
    internal enum ExpandedMovieItems {
        case Overview, OriginalLang, Popularity
    }

    class func createMapping(store: RKManagedObjectStore) -> RKEntityMapping {
        let mapping = RKEntityMapping(forEntityForName: CMMovie.mr_entityName(),
                                      in: store)
        
        let attributesDictionary: [String:String] = [
            "vote_count": "voteCount",
            "id": "id",
            "vote_average": "voteAverage",
            "title" : "title",
            "popularity": "popularity",
            "poster_path": "posterImagePath",
            "original_language": "originalLang",
            "original_title": "originalTitle",
            "backdrop_path": "backdropPath",
            "adult": "adult",
            "overview": "overview",
            "release_date": "releaseDate"
        ]
        mapping?.addAttributeMappings(from: attributesDictionary)
        mapping?.identificationAttributes = ["id"]
        return mapping!
    }
    
}


