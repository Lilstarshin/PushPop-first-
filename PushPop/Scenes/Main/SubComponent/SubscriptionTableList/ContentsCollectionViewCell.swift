//
//  ContentsCollectionViewColl.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/26.
//

import UIKit
import SnapKit
import Kingfisher


class ContentsCollectionViewCell: UICollectionViewCell {
  

  private var contentThumbnail: UIImageView = {
//    let image = UIImage(named: "default_person") ?? UIImage()
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    return imageView
  }()
  
  func setup(content: ContentsVO) {
    let imageViewInset: CGFloat = 15.0
    [
      contentThumbnail
    ].forEach { addSubview($0) }
    contentThumbnail.snp.makeConstraints {
      $0.top.equalToSuperview().inset(imageViewInset)
      $0.leading.equalToSuperview().inset(imageViewInset)
      $0.trailing.equalToSuperview().inset(imageViewInset)
      $0.bottom.equalToSuperview().inset(imageViewInset)
    }
    contentThumbnail.kf.setImage(with: URL(string: content.thumbnail), placeholder: UIImage(named: "default_person"))
  }
}
