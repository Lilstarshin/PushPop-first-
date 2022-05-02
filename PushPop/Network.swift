//
//  Network.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/29.
//

import Foundation
import Alamofire

class Network {
  private static let youtubeV3Url: String  =
    "https://www.googleapis.com/youtube/v3/"

  private static var systemInfo: NSDictionary = {
    guard let url = Bundle.main.url(forResource: "SystemInfo", withExtension: "plist") ,let dictionary = NSDictionary(contentsOf: url) else { return NSDictionary() }
    return dictionary
  }()
}

// MARK: - Youtube API
extension Network {
  static func searchChannel(query q: String , completion: (([Channel])->Void)? = nil ){
    guard let apiKey = systemInfo["YouTubeKey"] as? String ,!(q.isEmpty) else { return }
   
    let params = [
      "part"       : "snippet",
      "type"       : "channel",
      "maxResults" : "3",
      "q"          : "\(q)",
      "key"        : apiKey,
     ]
    let searchUrl = youtubeV3Url + "search"
    let request = AF
      .request(searchUrl, method: .get, parameters: params)
      request
      .cURLDescription(calling: { curl in
        print("curl:\(curl)")
      })
      .responseDecodable(of: YoutubeV3SearchChannel.self) { res in
        guard case .success(let data) = res.result else { return }
        completion?(data.items)
      }
      .resume()
  }
  
  static func searchVideoList(channelID: String , completion: (([VideoItem])->Void)? = nil ){
    guard let apiKey = systemInfo["YouTubeKey"] as? String
      else { return }
   
    let params = [
      "channelId"  : channelID,
      "part"       : "snippet",
      "maxResults" : "10",
      "order"      : "date",
      "key"        : apiKey,
     ]
    let searchUrl = youtubeV3Url + "search"
    let request = AF
      .request(searchUrl, method: .get, parameters: params)
      request
      .cURLDescription(calling: { curl in
        print("searchUrl: \(searchUrl)")
        print("curl:\(curl)")
      })
      .responseDecodable(of: YoutubeV3SearchVideoList.self) { res in
        guard case .success(let data) = res.result else {
          print("RES : \(res)")
          return
          
        }
        completion?(data.items)
      }
      .resume()
  }
  
}
