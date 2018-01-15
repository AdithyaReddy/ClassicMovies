//
//  CMMovie+Mapping.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 15/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import Foundation

extension CMMovie {
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
