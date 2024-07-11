//  LoginViewController.swift
//  iText
//  Created by Stanislaw Astashenko on 11/07/2024.

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //TextFields
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.placeholder = "Enter your email"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.textColor = .black
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.textColor = .black
        field.isSecureTextEntry = true
        return field
    }()
    
    //LogIn Button
    
    private let loginButton: UIButton = {
        let button = UIButton ()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white ,for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log in"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign In",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        loginButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        emailField.delegate = self
        passwordField.delegate = self
        
        // Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let imageSize = scrollView.width/4
        
        imageView.frame = CGRect(x: (scrollView.width - imageSize)/2,
                                 y: 20,
                                 width: imageSize,
                                 height: imageSize)
        
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 56)
        passwordField.frame = CGRect(x: 30,
                                  y: emailField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 56)
        loginButton.frame = CGRect(x: 30,
                                  y: passwordField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 56)
        
    }
    
    @objc func didTapLogIn() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text ,
              let password = passwordField.text,
              !email.isEmpty, 
              !password.isEmpty,
              password.count >= 6
        else {
            userLoginError()
            return
        }
        
        //FireBase LogIn
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            guard let result = result, error == nil else {
                print("FAILED TO LOGIN USER - \(email)")
                return
            }
            let user = result.user
            print("LOGGED IN - \(user)")
        })
    }
    
    func userLoginError() {
        let alert = UIAlertController(title: "Woops..",
                                      message: "Please make sure your data is correct!",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    @objc func didTapRegister() {
        
        let regVC = RegisterViewController()
        regVC.title = "Create Account"
        navigationController?.pushViewController(regVC, animated: true)
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField  == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLogIn()
        }
        
        return true
    }
}
