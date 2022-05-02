//
//  Search.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/27.
//

import Foundation



// MARK: - Search
struct YoutubeV3SearchChannel: Decodable {

  let kind, etag, nextPageToken: String
  let regionCode: String
  let pageInfo: ChannelPageInfo
  let items : [Channel]
}

// MARK: - Item
struct Channel: Decodable {
  let snippet: ChannelDetail
  var channelId: String { snippet.channelID }
  var title: String { snippet.title }
  var description: String { snippet.snippetDescription }
  var thumbnail: String { snippet.thumbnails.thumbnailsDefault.url }

}

// MARK: - Snippet
struct ChannelDetail: Decodable {
  let publishedAt: String
  let channelID, title, snippetDescription: String
  let thumbnails: ChannelThumbnails
  let channelTitle, liveBroadcastContent: String
  let publishTime: String
  
  enum CodingKeys: String, CodingKey {
    case publishedAt
    case channelID = "channelId"
    case title
    case snippetDescription = "description"
    case thumbnails, channelTitle, liveBroadcastContent, publishTime
  }
}

// MARK: - Thumbnails
struct ChannelThumbnails: Decodable {
  let thumbnailsDefault, medium, high: ChannelDefault
  
  enum CodingKeys: String, CodingKey {
    case thumbnailsDefault = "default"
    case medium, high
  }
}

// MARK: - Default
struct ChannelDefault: Decodable {
  let url: String
}

// MARK: - PageInfo
struct ChannelPageInfo: Decodable {
  let totalResults, resultsPerPage: Int
}
