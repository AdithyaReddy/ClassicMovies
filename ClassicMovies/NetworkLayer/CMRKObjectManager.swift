//
//  CMRKObjectManager.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 15/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import Foundation

class CMRKObjectManager: RKObjectManager {
    override open func getObject(_ object: Any!, path: String!, parameters: [AnyHashable : Any]!, success: ((RKObjectRequestOperation?, RKMappingResult?) -> Void)!, failure: ((RKObjectRequestOperation?, Error?) -> Void)!) {
        
        super.getObject(object, path: path, parameters: parameters, success: { (operation, result) in
            success(operation, result)
        }, failure: { (operation, error) in
            failure(operation, error)
        })
    }
}
