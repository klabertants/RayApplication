//
//  YapStorage.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import Foundation
import YapDatabase
import FastCoding

final class YapStorage {
    
    init() {
        self.storage = YapDatabase(path: dbPath(),
                                   serializer: serializer,
                                   deserializer: deserializer)!
        self.connection = storage.newConnection()
    }
    
    func readWrite(with block: @escaping (YapDatabaseReadWriteTransaction) -> Void ) {
        self.connection.readWrite(block)
        NotificationCenter.default.post(name: Notification.yapStorageModified, object: nil)
    }
    
    func read(with block: @escaping (YapDatabaseReadTransaction) -> Void ) {
        self.connection.read(block)
    }
    
    private let connection: YapDatabaseConnection
    private let storage: YapDatabase
    
    private let serializer: YapDatabaseSerializer = { (_, _, object) in
        return FastCoder.data(withRootObject: object)
    }
    
    private let deserializer: YapDatabaseDeserializer = { (_, _, data) in
        return FastCoder.object(with: data)
    }
}

private func dbPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let baseDirectory = paths.count > 0 ? paths[0] : NSTemporaryDirectory()
    let databasePath = URL(fileURLWithPath: baseDirectory).appendingPathComponent("rayDB.sqlite")
    return databasePath.absoluteString
}

extension Notification {
    static let yapStorageModified : Notification.Name = Notification.Name(rawValue: "yapStorageModified")
}
