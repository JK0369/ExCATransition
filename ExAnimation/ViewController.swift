//
//  ViewController.swift
//  ExAnimation
//
//  Created by 김종권 on 2023/01/08.
//

import UIKit

class ViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("present", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(openVC2), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        button.layer.add(transition, forKey: kCATransition)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc private func openVC2() {
        let vc = VC2()
        vc.modalPresentationStyle = .fullScreen
        let naviVC = UINavigationController(rootViewController: vc)
        
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
        present(naviVC, animated: false, completion: nil)
    }
}

class VC2: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("push", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("dismiss", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        [pushButton, dismissButton]
            .forEach(stackView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func pushVC() {
        navigationController?.view.layer.add(CATransition().segueFromBottom(), forKey: kCATransition)
        navigationController?.pushViewController(VC3(), animated: false)
    }
    
    @objc private func dismissVC() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
}

class VC3: UIViewController {
    private let popButton: UIButton = {
        let button = UIButton()
        button.setTitle("pop", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(popButton)
        NSLayoutConstraint.activate([
            popButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func popVC() {
        navigationController?.view.layer.add(CATransition().segueFromTop(), forKey: kCATransition)
        navigationController?.popViewController(animated: false)
    }
}

// https://stackoverflow.com/questions/51675063/how-to-present-view-controller-from-left-to-right-in-ios
extension CATransition {
    func segueFromBottom() -> CATransition {
        duration = 0.375 //set the duration to whatever you'd like.
        timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        type = .moveIn
        subtype = .fromTop
        return self
    }
    
    func segueFromTop() -> CATransition {
        duration = 0.375 //set the duration to whatever you'd like.
        timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        type = .moveIn
        subtype = .fromBottom
        return self
    }
    
    func segueFromLeft() -> CATransition {
        duration = 0.1 //set the duration to whatever you'd like.
        timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        type = .moveIn
        subtype = .fromLeft
        return self
    }
    
    func popFromRight() -> CATransition {
        duration = 0.1 //set the duration to whatever you'd like.
        timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        type = .reveal
        subtype = .fromRight
        return self
    }
    
    func popFromLeft() -> CATransition {
        duration = 0.1 //set the duration to whatever you'd like.
        timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        type = .reveal
        subtype = .fromLeft
        return self
    }
}
