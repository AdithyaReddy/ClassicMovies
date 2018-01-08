//
//  CMMovie.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 07/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit
import CoreData

class CMMovie: NSManagedObject {

    @NSManaged var title: String?
    @NSManaged var rating: NSNumber?
    @NSManaged var reviews: AnyObject?
    @NSManaged var releasDate: Date?
    @NSManaged var cast: AnyObject?
    
}


