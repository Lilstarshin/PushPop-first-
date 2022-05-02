//
//  ContentsVO.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/28.
//

import Foundation
import CoreData

class  ContentsVO {
  let channelId: String
  let contentId: String
  let likeCount: Int16
  let thumbnail: String
  let objectID: NSManagedObjectID?
  
  init(channelId: String, contentId: String, likeCount: Int16, thumbnail: String, objectID: NSManagedObjectID? ) {
    self.channelId = channelId
    self.contentId = contentId
    self.likeCount = 0
    self.thumbnail = thumbnail
    self.objectID = objectID
  }

}
