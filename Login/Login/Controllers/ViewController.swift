//
//  ViewController.swift
//  Login
//
//  Created by 김태완 on 9/11/24.
//

import UIKit

final class ViewController: UIViewController {

    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }
    
    func setupAddTarget() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        print("loginButton")
    }

    @objc func resetButtonTapped() {
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        let succes = UIAlertAction(title: "확인", style: .default) { action in print("success") }
        let cancel = UIAlertAction(title: "취소", style: .default) { cancle in print("cancle") }
        
        alert.addAction(succes)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
}


