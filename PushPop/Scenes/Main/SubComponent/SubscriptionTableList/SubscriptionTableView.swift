//
//  SubscriptionTableView.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/26.
//

import UIKit
import SnapKit

class SubscriptionTableView: UITableView {
  
  var subscripList: [SubscriptionInfoVO] = []
  let subDAO = SubscriptionInfoDAO()
  let conDAO = ContentsDAO()
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    setup()
    fetch()
    
  
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
extension SubscriptionTableView {
  func setup() {
    delegate = self
    dataSource = self
    
    register(SubscriptionTableViewCell.self, forCellReuseIdentifier: "SubscriptionTableViewCell")
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(subscripDataNotification(_:)),
      name: Notification.Name("SubscripData"),
      object: nil
    )
  }
  
  func fetch() {
    subscripList = subDAO.fetch()
    subscripList.forEach {
      print("TEST FIRST :: \($0.title)")
    }
    subscripList.forEach { subItem in
      Network.searchVideoList(channelID: subItem.channelId) { videos in
        subItem.contents =
        videos.map { video -> ContentsVO in
          let contentVO = ContentsVO(
            channelId: subItem.channelId,
            contentId: video.videoId,
            likeCount: 0,
            thumbnail: video.thumbnail,
            objectID: nil
          )
          _ = self.conDAO.insert(contentVO)
          print("TEST 2:: \(contentVO.contentId) ")
          return contentVO
        }
        self.reloadData()
      }
    }
  }
  
}
extension SubscriptionTableView {
  
  @objc func subscripDataNotification(_ noti: Notification) {
    guard let subscripData: [SubscriptionInfoVO] = noti.userInfo?["subscrip"] as? [SubscriptionInfoVO] else { return }
    subscripList = subscripData
    DispatchQueue.main.async { [weak self] in
      self?.fetch()
      self?.reloadData()
    }
  }
}
extension SubscriptionTableView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50.0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    
    return subscripList.count
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50.0
  }
 
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = HeaderView(frame: .zero)
    headerView.setup(subscripInfo: subscripList[section])
    return headerView
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView()
    
    footerView.backgroundColor = UIColor.clear
       return footerView
  }
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 10
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = dequeueReusableCell(withIdentifier: "SubscriptionTableViewCell", for: indexPath)
            as? SubscriptionTableViewCell else { return UITableViewCell() }
    
    print(" TEST :: \(subscripList[indexPath.section].contents)")
    cell.setup(subscripInfo: subscripList[indexPath.section] )
    
    return cell
  }
  
  
  
  
}
extension SubscriptionTableView: UITableViewDelegate {
  
}



