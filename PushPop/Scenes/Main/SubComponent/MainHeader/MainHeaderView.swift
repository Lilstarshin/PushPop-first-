//
//  MainHeaderView.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/27.
//

import SnapKit
import UIKit

protocol HeaderviewDelegate {
  func present(_ : Any)
}

class MainHeaderView: UIView {
  
  var delegate: HeaderviewDelegate?
  
  private lazy var logoLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Snell Roundhand", size: 30.0)
    label.text = "PushPop"
    
    return label
  }()
  
  private lazy var searchButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    button.contentVerticalAlignment = .fill
    button.contentHorizontalAlignment = .fill
    button.tintColor = .label
    button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
    return button
  }()
  
  private lazy var alarmButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "bell"), for: .normal)
    button.contentVerticalAlignment = .fill
    button.contentHorizontalAlignment = .fill
    button.tintColor = .label
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MainHeaderView  {
  @objc func didTapSearchButton() {
    
    if let delegate = delegate {
      delegate.present(self)
    }
  }
}

private extension MainHeaderView {
  func setup() {
  
    [
      logoLabel,
      searchButton,
      alarmButton,
    ].forEach { addSubview($0) }
    logoLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(50)
      $0.top.bottom.equalToSuperview()
      $0.width.equalTo(UIScreen.main.bounds.width / 2)
    }
    searchButton.snp.makeConstraints {
      $0.centerY.equalTo(logoLabel)
      $0.trailing.equalTo(alarmButton.snp.leading).offset(-20)
      $0.width.equalTo(30)
      $0.height.equalTo(30)
    }
    alarmButton.snp.makeConstraints {
      $0.centerY.equalTo(logoLabel)
      $0.trailing.equalToSuperview().inset(10)
      $0.width.equalTo(searchButton)
      $0.height.equalTo(searchButton)
    }
  }
}


