//
//  SearchList.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/27.
//

import UIKit
import NotificationCenter
class SearchList: UITableView {
  
  var searchDataList: [Channel] = []
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    setTableView()
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(didReceiveSearchDataNotification(_:)),
      name: Notification.Name("DidReceiveSearchData"),
      object: nil
    )
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}

private extension SearchList {
  func setTableView() {
    delegate = self
    dataSource = self
    isHidden = true
    register(SearchListCell.self, forCellReuseIdentifier: "SearchListCell")
  }
  
}
extension SearchList {
  
  @objc func didReceiveSearchDataNotification(_ noti: Notification) {
    guard let searchData: [Channel] = noti.userInfo?["search"] as? [Channel] else { return }
    print("Notification : \(searchData)")
    searchDataList = searchData
    if searchDataList.count != 0 { isHidden = false }
    DispatchQueue.main.async { [weak self] in
      self?.reloadData()
    }
  }
}

extension SearchList: UITableViewDelegate {
  
}
extension SearchList: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchDataList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = dequeueReusableCell(withIdentifier: "SearchListCell", for: indexPath)
            as? SearchListCell else { return UITableViewCell() }
    let searchData = searchDataList[indexPath.row]
    cell.vo = SubscriptionInfoVO.convertApiData(item: searchData)
    
    return cell
  }
  
  
}
