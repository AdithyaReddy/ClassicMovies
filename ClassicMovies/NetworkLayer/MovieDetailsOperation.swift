//
//  MovieDetailsOperation.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 07/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

import UIKit

class MovieDetailsOperation: BaseOperation {
    
    public func acknowledgeNotification(transactionId: String) {
        urlPath = ackOperationDelegate?.getBaseUrl() ?? "https://www.urbanclap.com"
        let manager = super.initSessionManager()
        
        var params: [String: AnyObject] = [String: AnyObject]()
        params["transaction_id"] = transactionId as AnyObject
        params["status"] = NotificationStatusConstants.opened as AnyObject
        params["device_type"] = ackOperationDelegate?.getDeviceType() as AnyObject
        params["device_id"] = ackOperationDelegate?.getApnsId() as AnyObject
        
        manager.post(NetworkingConstants.notificationUrlPath, parameters: params, progress: { (progressValue) in
            print(progressValue)
        }, success: { (data, result) in
            print(result)
        }) { (data, error) in
            print(error)
        }
    }
}
