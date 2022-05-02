//
//  SubscriptionInfoVO.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/28.
//

import Foundation
import CoreData

class SubscriptionInfoVO {
  let channelId: String
  let title: String
  let channelDescription: String
  let thumbnail: String
  let lastUpdate: Date
  var contents: [ContentsVO]?
  let objectID: NSManagedObjectID?
  
  init(channelId: String, title: String, channelDescription: String, thumbnail: String ,contents: [ContentsVO]? , objectID: NSManagedObjectID?) {
    self.channelId = channelId
    self.title = title
    self.channelDescription = channelDescription
    self.thumbnail = thumbnail
    self.lastUpdate = Date()
    self.contents = contents
    self.objectID = objectID
  }
  
  static func convertApiData(item: Channel) -> SubscriptionInfoVO {
    return SubscriptionInfoVO(
      channelId: item.channelId,
      title: item.title,
      channelDescription: item.description,
      thumbnail: item.thumbnail,
      contents: [ContentsVO](),
      objectID: nil
    )
  }
}
