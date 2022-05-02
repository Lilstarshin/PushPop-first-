//
//  TabBarController.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/26.
//
import UIKit

class TabBarController: UITabBarController {
  
  private lazy var todayViewController: UIViewController = {
    let viewController = MainViewController()
    let tabBarItem = UITabBarItem(
      title: nil,
      image: UIImage(systemName: "house"),
      tag: 0
    )
    viewController.tabBarItem = tabBarItem
    return viewController
  }()
  
//  private lazy var appViewController: UIViewController = {
//    let viewController = UINavigationController(rootViewController: AppViewController())
//    let tabBarItem = UITabBarItem(
//      title: nil,
//      image: UIImage(systemName: "book"),
//      tag: 1
//    )
//    viewController.tabBarItem = tabBarItem
//    return viewController
//  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewControllers = [todayViewController,]
  }
}

