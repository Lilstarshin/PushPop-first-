//
//  SearchBar.swift
//  ShareExp
//
//  Created by 신새별 on 2022/04/27.
//

import UIKit
import SnapKit
import Alamofire


let DidReceiveSearchDataNotification: Notification.Name = Notification.Name("DidReceiveSearchData")

class SearchBar: UISearchBar {
  
  
  var searchDelegate: SearchViewControllerDelegate?
  
  private lazy var cancelButton: UIButton = {
    let button = UIButton()
    button.setTitle("취소", for: .normal)
    button.setTitleColor(UIColor.label, for: .normal)
    button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    layout()
    attribute()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SearchBar {
  @objc func didTapCancelButton() {
    
    if let searchDelegate = searchDelegate {
      searchDelegate.dismiss(self)
    }
  }
}
extension SearchBar:UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    searchDelegate?.startIndicatorAnimating()
    print("clicked")
    let serchText = searchBar.text ?? ""
    DispatchQueue.global(qos: .background).async { [weak self] in
      self?.search(text: serchText)
      DispatchQueue.main.async {
        self?.searchDelegate?.stopIndicatorAnimating()
      }
    }
  }
}

private extension SearchBar {
  func layout() {
    print("SearchBar layout")
    addSubview(cancelButton)
    searchTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(12)
      $0.trailing.equalTo(cancelButton.snp.leading).offset(-12)
      $0.centerY.equalToSuperview()
    }
    cancelButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(12)
    }
  }
  func search(text: String) {
    print("##func start")
    Network.searchChannel(query: text) { items in
      NotificationCenter.default.post(name: DidReceiveSearchDataNotification, object: nil, userInfo: ["search" : items])
    }
    print("##func end")
  }
  func attribute() {
    placeholder = "알람을 수신할 유명인을 검색해보세요"
    delegate = self
    
  }
}
