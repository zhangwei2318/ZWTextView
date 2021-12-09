//
//  ViewController.swift
//  ZWTextView
//
//  Created by zhangwei2318 on 11/15/2021.
//  Copyright (c) 2021 zhangwei2318. All rights reserved.
//

import UIKit
import ZWTextView
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .red
        
        
        let textV = ZWTextView.init()
        textV.backgroundColor = .yellow
        textV.placeholder = "测试"
        textV.placeholderColor = .red
        textV.textColor = .green
        textV.maxCount = 10
        view.addSubview(textV)
        textV.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(100)
            make.height.equalTo(150)
        }
        
        textV.textChange = { str in
            print("文字改变: \(str)")
        }
        
        textV.textEndEditing = { str in
            print("文字结束编辑: \(str)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

