//
//  MainViewController.swift
//  ShareExp
//
//  Created by 신새별 on 2022/04/25.
//

import UIKit
import SnapKit



class MainViewController: UIViewController {
  let subscripDAO = SubscriptionInfoDAO()
  let contentsDAO = ContentsDAO()
  let headerView = MainHeaderView(frame: .zero)
  let subscriptionList = SubscriptionTableView()
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
}


extension MainViewController: HeaderviewDelegate {
  func present(_ : Any) {
    let vc = SearchViewController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true)
    
  }
}

private extension MainViewController {
  func setup() {
    
    view.backgroundColor = .systemBackground
    [
      headerView,
      subscriptionList,
    ].forEach { view.addSubview($0) }
    headerView.delegate = self
    headerView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(50.0)
    }
    subscriptionList.snp.makeConstraints {
      $0.top.equalTo(headerView.snp.bottom)
      $0.trailing.leading.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    
  }
}



