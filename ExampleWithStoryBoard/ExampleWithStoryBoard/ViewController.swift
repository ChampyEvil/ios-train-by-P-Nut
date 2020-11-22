//
//  ViewController.swift
//  ExampleWithStoryBoard
//
//  Created by Thirawuth on 21/11/2563 BE.
//

import UIKit

class LoginViewController: UIViewController{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = "admin"
        passwordTextField.text = "password"
    }
    
    @IBAction func onSignIn() {
        if usernameTextField.text == "admin" && passwordTextField.text == "password"{
//            let myStorBoard = UIStoryboard(name: "MyStoryboard", bundle: .none)
//            let homeViewController = myStorBoard.instantiateViewController(identifier: "HomeScreen")
//            navigationController?.pushViewController(homeViewController, animated: true)
            let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: .none)
            navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
}

class HomeViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Home"
        
        let usernameTextBox = UITextField()
        usernameTextBox.translatesAutoresizingMaskIntoConstraints = false
        usernameTextBox.placeholder = "username"
        
        let passwordTextBox = UITextField()
        passwordTextBox.translatesAutoresizingMaskIntoConstraints = false
        passwordTextBox.placeholder = "password"
        
        let signInButton = UIButton(type: .system)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: .normal)
        
        view.addSubview(label)
        view.addSubview(usernameTextBox)
        view.addSubview(passwordTextBox)
        view.addSubview(signInButton)
        
//        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
//        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextBox.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            usernameTextBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextBox.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            passwordTextBox.topAnchor.constraint(equalTo: usernameTextBox.bottomAnchor, constant: 20),
            passwordTextBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextBox.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            signInButton.topAnchor.constraint(equalTo: passwordTextBox.bottomAnchor, constant: 40),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onButtonTouch() {
        performSegue(withIdentifier: "showScreenB", sender: .none)
    }
    
}

class ViewControllerB: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onButtonTouch() {
        performSegue(withIdentifier: "showScreenC", sender: .none)
    }
    
}

class ViewControllerC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onButtonTouchJump(_ sender: Any) {
        let screenA = navigationController?.viewControllers.first(where: {$0 is ViewController})
        guard let _toVCA = screenA else {return}
        navigationController?.popToViewController(_toVCA, animated: true)
    }
}

