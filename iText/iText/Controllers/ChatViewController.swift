//  ViewController.swift
//  iText
//  Created by Stanislaw Astashenko on 11/07/2024.


import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "Welcome Screen"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

        checkAuthStatus()
        DatabaseManager.shared.testDB()
    }
    
    private func checkAuthStatus() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}

