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
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        

        
        // 버튼의 제목을 설정합니다.
        btn.setTitle("Hello World !", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        // 뷰의 배경색을 회색으로 설정합니다.
        view.backgroundColor = .white
        
        // 버튼을 뷰의 중앙에 위치시킵니다.
        btn.center = view.center
        
        // 버튼을 뷰에 추가합니다.
        view.addSubview(btn)
    }


}

