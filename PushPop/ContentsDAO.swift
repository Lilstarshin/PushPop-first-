//
//  ContentsDAO.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/29.
//

import Foundation
import CoreData
import UIKit


class ContentsDAO {
  private let subscripDAO = SubscriptionInfoDAO()
  private lazy var context: NSManagedObjectContext = {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    return appDelegate.persistentContainer.viewContext
  }()
  
  // MARK: - Data fetch
  func fetch(key: String? = nil, value: String? = nil) -> [ContentsVO] {
    var subscriptionlist: [ContentsVO] = []

    let fetchRequest: NSFetchRequest<ContentsMO> =  ContentsMO.fetchRequest()
    if let value = value, value.isEmpty == false,
       let key = key, key.isEmpty == false {
      fetchRequest.predicate = NSPredicate(format: "%@ == %@",key , value)
    }
    do {
      let resultSet = try self.context.fetch(fetchRequest)
      
      for record in resultSet {
        subscriptionlist.append(ContentsVO(
          channelId: record.channelId ?? "",
          contentId: record.contentId ?? "",
          likeCount: record.likeCount ,
          thumbnail: record.thumbnail ?? "",
          objectID: record.objectID
        ))
        
      }
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
    }
    
    return subscriptionlist
  }
  
  // MARK: - Data insert
  func insert (_ data: ContentsVO) -> Bool {
    
    guard let object = NSEntityDescription.insertNewObject(
      forEntityName: "Contents",
      into: context
    ) as? ContentsMO else { return false }
    
    object.channelId          = data.channelId
    object.contentId          = data.contentId
    object.likeCount          = data.likeCount
    object.thumbnail          = data.thumbnail
    do {
      try context.save()
      // TODO: Upload to server
      
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
      return false
    }
    return true
  }
  // MARK: - Data delete
  func delete(_ objectID: NSManagedObjectID) -> Bool {
    
    let object = context.object(with: objectID)
    context.delete(object)
    
    do {
      try context.save()
    } catch let e as NSError {
      NSLog("An error has occurred: %s", e.localizedDescription)
      return false
    }
    return true
  }
}
