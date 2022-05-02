//
//  SceneDelegate.swift
//  PushPop
//
//  Created by 신새별 on 2022/04/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    let rootViewController = TabBarController()
    window?.rootViewController =  rootViewController
    window?.makeKeyAndVisible()
    
    if #available(iOS 13.0, *) {
      window?.overrideUserInterfaceStyle = .light
    }
  }
}

