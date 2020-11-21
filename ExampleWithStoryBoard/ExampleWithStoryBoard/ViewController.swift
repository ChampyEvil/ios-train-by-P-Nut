//
//  ViewController.swift
//  ExampleWithStoryBoard
//
//  Created by Thirawuth on 21/11/2563 BE.
//

import UIKit

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

