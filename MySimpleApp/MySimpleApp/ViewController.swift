//
//  ViewController.swift
//  MySimpleApp
//
//  Created by Thirawuth on 21/11/2563 BE.
//

import UIKit

class ViewControllerA: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Screen A : viewDidLoad")
        title = "Screen A"
        view.backgroundColor = .white
        
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Go Screen B", for: .normal)
        nextButton.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        view.addSubview(nextButton)
        
        let openModalButton = UIButton(type: .system)
        openModalButton.setTitle("Open Modal C", for: .normal)
        openModalButton.frame = CGRect(x: 0, y: 200, width: 100, height: 100)
        view.addSubview(openModalButton)
        
        nextButton.addTarget(self, action: #selector(onButtonTouchUpInsideA), for: .touchUpInside)
        openModalButton.addTarget(self, action: #selector(onButtonTouchUpInsideOpenModalA), for: .touchUpInside)
    }
    
    @objc func onButtonTouchUpInsideA(_ sender: UIButton){
        print("Inside A")
        navigationController?.pushViewController(ViewControllerB(), animated: true)
    }
    
    @objc func onButtonTouchUpInsideOpenModalA(_ sender: UIButton){
        print("Inside Modal A")
        let navigationController = UINavigationController(rootViewController: ViewControllerC())
//        navigationController?.pushViewController(ViewControllerC(), animated: true)
        present(navigationController, animated: true, completion: .none)
//        dismiss(animated: true, completion: .none)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Screen A: viewWillAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Screen A: viewWillDisappear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Screen A: viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Screen A: viewDidDisappear")
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("Screen A: viewWillLayutSubviews")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Screen A: viewDidLayoutSubviews")
    }
}

class ViewControllerB: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Screen B"
        view.backgroundColor = .white
        print("Screen B : viewDidLoad")
        
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Go Screen C", for: .normal)
        nextButton.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        view.addSubview(nextButton)
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("Go Screen A", for: .normal)
        backButton.frame = CGRect(x: 0, y: 250, width: 100, height: 100)
        view.addSubview(backButton)
        
        backButton.addTarget(self, action: #selector(onButtonTouchUpInsideBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(onButtonTouchUpInsideNext), for: .touchUpInside)
    }
    
    @objc func onButtonTouchUpInsideBack(_ sender: UIButton){
        print("Inside back B")
        navigationController?.popViewController(animated: true)
    }
    @objc func onButtonTouchUpInsideNext(_ sender: UIButton){
        print("Inside next B")
        navigationController?.pushViewController(ViewControllerC(), animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Screen B: viewWillAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Screen B: viewWillDisappear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Screen B: viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Screen B: viewDidDisappear")
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("Screen B: viewWillLayutSubviews")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Screen B: viewDidLayoutSubviews")
    }
}

class ViewControllerC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Screen C"
        view.backgroundColor = .white
        
        let jumpButton = UIButton(type: .system)
        jumpButton.setTitle("Jump to A", for: .normal)
        jumpButton.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        view.addSubview(jumpButton)
        
        let closeModalButton = UIButton(type: .system)
        closeModalButton.setTitle("Close Modal", for: .normal)
        closeModalButton.frame = CGRect(x: 0, y: 150, width: 100, height: 100)
        view.addSubview(closeModalButton)
        
        jumpButton.addTarget(self, action: #selector(onButtonTouchUpInsideC), for: .touchUpInside)
        closeModalButton.addTarget(self, action: #selector(onButtonTouchUpInsideColseModal), for: .touchUpInside)
    }
    
    @objc func onButtonTouchUpInsideC(_ sender: UIButton){
        print("Inside C")
        let viewControllerA = navigationController?.viewControllers.first(where: {vc in vc is ViewControllerA})
        guard let _toVC = viewControllerA else {return}
        navigationController?.popToViewController(_toVC, animated: true)
//        navigationController?.popViewController(animated: true)
    }
    
    @objc func onButtonTouchUpInsideColseModal(_ sender: UIButton){
        print("Inside CC")
//        let viewControllerA = navigationController?.viewControllers.first(where: {vc in vc is ViewControllerA})
//        guard let _toVC = viewControllerA else {return}
        dismiss(animated: true, completion: .none)
//        navigationController?.popViewController(animated: true)
    }
}

