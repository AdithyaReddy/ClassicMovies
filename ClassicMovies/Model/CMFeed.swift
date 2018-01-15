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
    @NSManaged var results: NSSet?
    
}
