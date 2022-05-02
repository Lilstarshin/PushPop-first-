//
//  ViewController.swift
//  ShareExp
//
//  Created by 신새별 on 2022/04/25.
//

// Login View

import UIKit
import SnapKit
import AuthenticationServices

class LoginViewController: UIViewController {

  let stackViewSpacing: CGFloat = 3.0
  let loginButtonWidth: CGFloat = 50.0
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = stackViewSpacing
    return stackView
  }()
  
  // MARK: - Login Button (Tag -> apple:1, ...)
  lazy var appleIDLoginButton: ASAuthorizationAppleIDButton = {
    let loginButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
    loginButton.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
    return loginButton
  }()
  lazy var sampleLoginView1: UIView = {
    let spacer = UIView()
    spacer.tag = 2
    return spacer
  }()
  lazy var sampleLoginView2: UIView = {
    let spacer = UIView()
    spacer.tag = 3
    return spacer
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
}
extension LoginViewController: ASAuthorizationControllerDelegate {
//  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//    return self.view.window!
//  }
  
  @objc func didTapLoginButton(_ sender: UIButton) {
//    let appleIDProvider = ASAuthorizationAppleIDProvider()
//    let request = appleIDProvider.createRequest()
//    request.requestedScopes = [.fullName, .email]
//
//    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//    authorizationController.delegate = self
//    authorizationController.presentationContextProvider = self
//    authorizationController.performRequests()
    
    let mainVC = MainViewController()
    mainVC.modalPresentationStyle = .fullScreen
    present(mainVC, animated: true)
  }
}

private extension LoginViewController {
  
  func setupLayout() {
    view.backgroundColor = .white
    
    [stackView].forEach { view.addSubview($0)}
    
    [
      appleIDLoginButton,
      sampleLoginView1,
      sampleLoginView2
    ].forEach { stackView.addArrangedSubview($0) }

    
    stackView.snp.makeConstraints {
      $0.bottom.equalToSuperview().inset(50)
      $0.leading.trailing.equalToSuperview().inset(30)
      $0.height.equalTo(150)
    }
  }
}

