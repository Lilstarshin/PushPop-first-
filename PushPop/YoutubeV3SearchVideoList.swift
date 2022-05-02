//
//  YoutubeV3SearchVideoList.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/29.
//

import Foundation

// MARK: - YoutubeV3SearchVideoList
struct YoutubeV3SearchVideoList: Codable {
  let kind, etag, nextPageToken, regionCode: String
  let items: [VideoItem]
}

// MARK: - VideoItem
struct VideoItem: Codable {
  var videoId: String { id.videoID }
  var title: String { snippet.title }
  var snippetDescription: String { snippet.snippetDescription }
  var thumbnail: String { snippet.thumbnails.thumbnailsDefault.url }
  let id: VideoID
  let snippet: Video
}

// MARK: - Video
struct Video: Codable {

  let title, snippetDescription: String
  let thumbnails: VideoThumbnails
  
  enum CodingKeys: String, CodingKey {
    case title
    case snippetDescription = "description"
    case thumbnails
  }
}
// MARK: - ID
struct VideoID: Codable {
    let videoID: String
    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
    }
}


// MARK: - Thumbnails
struct VideoThumbnails: Codable {
  let thumbnailsDefault, medium, high: VideoDefault
  
  enum CodingKeys: String, CodingKey {
    case thumbnailsDefault = "default"
    case medium, high
  }
}

// MARK: - Default
struct VideoDefault: Codable {
  let url: String
  let width, height: Int
}

