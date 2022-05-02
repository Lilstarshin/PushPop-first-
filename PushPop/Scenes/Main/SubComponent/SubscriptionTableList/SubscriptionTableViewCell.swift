//
//  SubscriptionTableViewCell.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/26.
//

import UIKit
import SnapKit
import Kingfisher

class SubscriptionTableViewCell: UITableViewCell {
  var contentsList: [ContentsVO] = []
  private let cellWidth = ( UIScreen.main.bounds.width / 3 ) - 32
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
    layout.minimumInteritemSpacing = 3
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.register(ContentsCollectionViewCell.self, forCellWithReuseIdentifier: "ContentsCollectionViewCell")
    return collectionView
  }()
  
}

extension SubscriptionTableViewCell {
  func setup(subscripInfo: SubscriptionInfoVO) {
    self.contentsList = subscripInfo.contents ?? [ContentsVO]()
   
    
    contentView.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.leading.top.trailing.bottom.equalToSuperview()
    }
    collectionView.reloadData()
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
    contentView.frame = contentView.frame.inset(by: margins)
    contentView.layer.cornerRadius = 8
  }
  
}

extension SubscriptionTableViewCell: UICollectionViewDelegateFlowLayout {
  
}

extension SubscriptionTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return contentsList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCollectionViewCell", for: indexPath)
            as? ContentsCollectionViewCell else { return UICollectionViewCell() }
    cell.setup(content: contentsList[indexPath.item])
    
    return cell
  }
  
  
}
