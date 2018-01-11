//
//  BaseOperation.swift
//  ClassicMovies
//
//  Created by Adithya Reddy on 07/01/18.
//  Copyright © 2018 Adithya Reddy. All rights reserved.
//

public class BaseOperation: NSObject {
    
    var objectManager: RKObjectManager!
    
    override init() {
        super.init()
        let model = managedObjectModel()
        let store = managedObjectStore(model)
        let urlPath = NetworkConstants.baseUrl
        if let nsUrlPath = URL(string: urlPath) {
            objectManager = getObjectManager(nsUrlPath, store: store)
        }
    }
    
    func getObjectManager(_ url:URL,store:RKManagedObjectStore) -> RKObjectManager {
        let objectManager:RKObjectManager = CMRKObjectManager(baseURL: url)
        objectManager.managedObjectStore = store
        objectManager.requestSerializationMIMEType = RKMIMETypeJSON
        NSPersistentStoreCoordinator.mr_setDefaultStoreCoordinator(store.persistentStoreCoordinator)
        NSManagedObjectContext.mr_rootSaving()
        //NSManagedObjectContext.mr_resetDefaultContext()
        self.setDefaultDateFormatter()
        return objectManager
    }
    
    func managedObjectStore(_ model: NSManagedObjectModel) -> RKManagedObjectStore {
        
        let store:RKManagedObjectStore = RKManagedObjectStore(managedObjectModel: model)
        store.createPersistentStoreCoordinator()
        let storePath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("UCCustomer.sqlite")?.path
        do {
            try store.addSQLitePersistentStore(atPath: storePath,
                                               fromSeedDatabaseAtPath: nil, withConfiguration: nil, options: nil)
        } catch {
            print("ERROR")
        }
        
        store.createManagedObjectContexts()
        return store
    }
    
    func managedObjectModel() -> NSManagedObjectModel {
        let url =  Bundle.main.url(forResource: "ClassicMovies", withExtension: "momd")
        return NSManagedObjectModel(contentsOf: url!)!
    }
    
    func setDefaultDateFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'kk:mm:ss.SSSSSS'Z"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RKValueTransformer.defaultValueTransformer().insert(dateFormatter, at: 0)
    }
    
}

class CMRKObjectManager: RKObjectManager {
    override open func getObject(_ object: Any!, path: String!, parameters: [AnyHashable : Any]!, success: ((RKObjectRequestOperation?, RKMappingResult?) -> Void)!, failure: ((RKObjectRequestOperation?, Error?) -> Void)!) {
        
        super.getObject(object, path: path, parameters: parameters, success: { (operation, result) in
            success(operation, result)
        }, failure: { (operation, error) in
            failure(operation, error)
        })
    }
}
