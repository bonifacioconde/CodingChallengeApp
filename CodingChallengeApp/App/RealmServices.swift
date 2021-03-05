//
//  RealmServices.swift
//  CodingChallengeApp
//
//  Created by Bonz Condz on 17/01/2020.
//  Copyright © 2020 Boni. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

private let currentSchemaVersion: UInt64 = 5

typealias RealmObjectResult<T> = ((_: T) -> Void)

class RealmServices {
  
  class func setup() {
    // Setup realm
    let config = Realm.Configuration(
      schemaVersion: currentSchemaVersion,
      migrationBlock: { _, _ in
        print("migration succeeded")
    })
    Realm.Configuration.defaultConfiguration = config
    debugPrint("Path to realm file: " + RealmServices.shared.realm.configuration.fileURL!.absoluteString)
  }
  
  @discardableResult
  private init() {
  }
  
  static let shared = RealmServices()
  var realm = try! Realm()
  
  
  func post(_ error: Error) {
    NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
  }
  
  /*
   func observeRealmErrors(in vc: UIViewController, completion: @escaping (Error?) -> Void) {
   NotificationCenter.default
   .addObserver(forName: NSNotification.Name("RealmError"),
   object: nil,
   queue: nil) { (notification) in
   completion(notification.object as? Error)
   }
   }
   */
  
  
  func stopObservingErrors(in vc: UIViewController) {
    NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
  }
  // Fetch object
  func getObjects<T: Object>() -> [T] {
    let realmResults = realm.objects(T.self)
    return Array(realmResults)
    
  }
  func getObjects<T: Object>(filter: String) -> [T] {
    let realmResults = realm.objects(T.self).filter(filter)
    return Array(realmResults)
    
  }
  
  // Save Object
  func saveRealm<T: Object>(_ object: T) {
    do {
      try realm.write {
        realm.add(object, update: .all)
      }
    } catch {
      post(error)
    }
  }
  // Update Object
  func updateRealm<T: Object>(_ object: T, with dictionary: [String: Any?]) {
    do {
      try realm.write {
        for (key, value) in dictionary {
          object.setValue(value, forKey: key)
        }
      }
    } catch {
      post(error)
    }
  }
  // Delete Object
  func deleteRealm<T: Object>(_ object: T) {
    do {
      try realm.write {
        realm.delete(object)
      }
    } catch {
      post(error)
    }
  }
  
  func cleanRealm() {
    do {
      try realm.write {
        realm.deleteAll()
      }
    } catch {
      post(error)
    }
  }
}
