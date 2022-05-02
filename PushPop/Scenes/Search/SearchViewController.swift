//
//  SearchViewController.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/26.
//

import UIKit
import NVActivityIndicatorView


protocol SearchViewControllerDelegate {
  func startIndicatorAnimating()
  func stopIndicatorAnimating()
  func dismiss(_ : Any)
}


class SearchViewController: UIViewController {

  let searchBar = SearchBar(frame: .zero)
  let searchList = SearchList()
  lazy var indicator: NVActivityIndicatorView = {
    let indicator = NVActivityIndicatorView(
      frame: .zero,
      type: .ballRotateChase,
      color: .black,
      padding: 0
    )
    return indicator
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    setup()
  }
}
extension SearchViewController: SearchViewControllerDelegate {
  func startIndicatorAnimating() {
    indicator.startAnimating()
  }
  func stopIndicatorAnimating() {
    indicator.stopAnimating()
  }
  func dismiss(_: Any) {
    dismiss(animated: true)
  }
}

private extension SearchViewController {
  func layout() {
    view.backgroundColor = .systemBackground
    [
      searchBar,
      searchList,
      indicator,
    ].forEach { view.addSubview($0) }
    
    searchBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }
    searchList.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom).offset(-10)
      $0.leading.trailing.bottom.equalToSuperview()
    }
    indicator.snp.makeConstraints {
      $0.centerY.equalTo(searchList.snp.centerY)
      $0.centerX.equalTo(searchList.snp.centerX)
      $0.width.equalTo(50.0)
      $0.height.equalTo(50.0)
    }
  }
  func setup() {
    searchBar.searchDelegate = self
  }
}


