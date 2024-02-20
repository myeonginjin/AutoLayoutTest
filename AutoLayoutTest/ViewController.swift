//
//  ViewController.swift
//  AutoLayoutTest
//
//  Created by Jaein Yoo on 2/20/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 버튼을 생성합니다.
        let btn = UIButton(frame: .init())
        btn.translatesAutoresizingMaskIntoConstraints = false
        // 버튼의 제목을 설정합니다.
        btn.setTitle("Hello World !", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        // 뷰의 배경색을 회색으로 설정합니다.
        view.backgroundColor = .white
        // 버튼을 뷰의 중앙에 위치시킵니다.
        btn.center = view.center
        
        
        let lab =  UILabel(frame: .init())
        lab.backgroundColor = .red
        
        
        
        
        // 버튼을 뷰에 추가합니다.
        view.addSubview(btn)
        
        
        NSLayoutConstraint.activate([
            btn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            btn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            btn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        
//        btn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//        btn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
//        btn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        
        //uploda repo
    }


}

