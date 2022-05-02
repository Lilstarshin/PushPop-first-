//
//  SearchListCell.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/27.
//

import UIKit
import Kingfisher
import SnapKit

let SubscripDataDataNotification: Notification.Name = Notification.Name("SubscripData")
class SearchListCell: UITableViewCell {
  
  var vo: SubscriptionInfoVO?
  
  private lazy var dao = SubscriptionInfoDAO()
  private lazy var contentDAO = ContentsDAO()
  
  private lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    
    
    return imageView
  }()
  private lazy var channelNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .bold)
    
    return label
  }()

  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13, weight: .medium)
    
    return label
  }()
  private lazy var subscriptionButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    button.contentVerticalAlignment = .fill
    button.contentHorizontalAlignment = .fill
    button.tintColor = .label
    button.addTarget(self, action: #selector(didTapSubscriptionButton), for: .touchUpInside)
//    button.addTarget(self, action: nil, for: .touchUpInside)
    return button
  }()
 
}

extension SearchListCell {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    [
      profileImageView,
      channelNameLabel,
      descriptionLabel,
      subscriptionButton,
    ].forEach { contentView.addSubview($0) }
    print("Cell IN : \(vo)")
    guard let data = vo else { return }
    
    profileImageView.kf.setImage(with: URL(string: data.thumbnail), placeholder: UIImage())
    channelNameLabel.text = data.title
    descriptionLabel.text = data.channelDescription
    
    profileImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(5)
      $0.height.equalTo(40.0)
      $0.width.equalTo(40.0)
      $0.centerY.equalToSuperview()
    }
    profileImageView.layer.cornerRadius = 20
    profileImageView.layer.borderWidth = 1
    profileImageView.layer.borderColor = UIColor.white.cgColor
    profileImageView.layer.masksToBounds = false
    profileImageView.clipsToBounds = true
    
    channelNameLabel.snp.makeConstraints {
      $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
      $0.top.equalToSuperview().inset(5)
      $0.height.equalTo(20.0)
      $0.trailing.equalTo(subscriptionButton.snp.leading)
    }
    descriptionLabel.snp.makeConstraints {
      $0.leading.equalTo(channelNameLabel)
      $0.top.equalTo(channelNameLabel.snp.bottom).offset(-5)
      $0.height.equalTo(channelNameLabel)
      $0.trailing.equalTo(channelNameLabel)
    }
    subscriptionButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(5)
      $0.centerY.equalToSuperview()
      $0.height.equalTo(20.0)
      $0.width.equalTo(20.0)
    }
    let find = dao.fetch(channelId: data.channelId)
    if find.isEmpty  {
      subscriptionButton.isSelected = false
    } else {
      subscriptionButton.isSelected = true
    }
  }
  
  @objc func didTapSubscriptionButton() {
    guard let data = vo else { return }
    let objList = dao.fetch(channelId: data.channelId)

    if !subscriptionButton.isSelected {
      let duple = objList.contains { obj in
        obj.channelId == data.channelId
      }
      if !duple ,dao.insert(data) == true {
        subscriptionButton.isSelected = true
      } else {
        subscriptionButton.isSelected = false
      }
    } else {
      print("TEST 1")
      if let deleteObj = objList.first, dao.delete(deleteObj.objectID!) {
        print("TEST 2")
        subscriptionButton.isSelected = false
        let deleteContentList = contentDAO.fetch(key: "channelId", value: deleteObj.channelId)
        deleteContentList.forEach { content in
          if !(contentDAO.delete(content.objectID!)) {
            print("content data delete error ...!")
          }
        }
      }
     
      reloadInputViews()
    }
    NotificationCenter.default.post(name: SubscripDataDataNotification, object: nil, userInfo: ["subscrip" : dao.fetch()])

  
  }
}

