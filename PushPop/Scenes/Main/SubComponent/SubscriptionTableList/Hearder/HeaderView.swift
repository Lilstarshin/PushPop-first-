//
//  HeaderView.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/26.
//

import UIKit
import Kingfisher
import SnapKit

class HeaderView: UIView {
  var subscripInfo: SubscriptionInfoVO?
  private lazy var influencerProfileImg: UIImageView = {
    let imageView = UIImageView()
    imageView.kf.setImage(with: URL(string: "https://yt3.ggpht.com/ytc/AKedOLSiLNeP0lwshrXEamJ9XbEXbRsD4EcD-uEODnZE0w=s88-c-k-c0xffffffff-no-rj-mo"), placeholder: UIImage())
    imageView.contentMode = .scaleAspectFill
    imageView.frame.size = CGSize(width: 50, height: 50)
    print("influencerProfileImg \(imageView.frame.size)")
    imageView.layer.cornerRadius = imageView.frame.size.width / 2
    imageView.layer.borderWidth = 1
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.layer.masksToBounds = false
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var influencerName: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 13, weight: .bold)
    
    return label
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HeaderView {
  func setup(subscripInfo: SubscriptionInfoVO) {
    [
      influencerProfileImg,
      influencerName,
    ].forEach { addSubview($0) }
    influencerProfileImg.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview().inset(5)
      $0.bottom.equalToSuperview()
      $0.width.equalTo(50)
    }
    influencerProfileImg.kf.setImage(with: URL(string: subscripInfo.thumbnail), placeholder: UIImage())

    
    influencerName.snp.makeConstraints {
      $0.top.equalTo(influencerProfileImg.snp.top)
      $0.bottom.equalTo(influencerProfileImg.snp.bottom)
      $0.leading.equalTo(influencerProfileImg.snp.trailing).offset(10)
      $0.trailing.equalToSuperview().inset(5)
    }
    influencerName.text = subscripInfo.title
  }
}
