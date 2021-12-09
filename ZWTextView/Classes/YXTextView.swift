//
//  ZWTextView.swift
//
//  Created by 张伟 on 2021/5/25.
//  Copyright © 2021 YJJ－CHY. All rights reserved.
//

import UIKit
import SnapKit

extension UIColor {
    public convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    class var color238238238: UIColor {
        return UIColor(r: 16, g: 82, b: 247)
    }
    
    class var color515151: UIColor {
        return UIColor(r: 51, g: 51, b: 51)
    }
}


public class ZWTextView: UIView {
    // 文字改变回调
    public var textChange: ((_ str: String) -> Void)?
    
    // 结束编辑回调
    public var textEndEditing: ((_ str: String) -> Void)?
    
    // 文字大小
    public var fontSize: CGFloat = 15 {
        didSet {
            textView.font = UIFont.systemFont(ofSize: fontSize)
            textPlView.font = UIFont.systemFont(ofSize: fontSize)
            maxNumLabel.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    // 占位符
    public var placeholder: String = "请输入内容..." {
        didSet {
            textPlView.text = placeholder
        }
    }
    
    // 最大位数, 默认无限制,不显示
    public var maxCount: Int? {
        didSet {
            maxNumLabel.isHidden = false
        }
    }
    
    // 文字颜色
    public var textColor: UIColor = .color515151 {
        didSet {
            textView.textColor = textColor
        }
    }
    
    // 占位符颜色
    public var placeholderColor: UIColor = .lightGray {
        didSet {
            textPlView.textColor = placeholderColor
        }
    }
    
    // 最大位数颜色
    public var maxCountColor: UIColor = .lightGray {
        didSet {
            maxNumLabel.textColor = maxCountColor
        }
    }
    
    public override init(frame: CGRect) {
        super .init(frame: frame)
        configueLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configueLayout() {
        backgroundColor = .color238238238
        addSubview(textView)
        addSubview(textPlView)
        addSubview(maxNumLabel)
        
        textView.snp.makeConstraints { (make) in
            make.left.top.equalTo(5)
            make.right.bottom.equalTo(-5)
        }
        
        textPlView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(textView)
        }

        maxNumLabel.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-11)
        }
    }
    /**
     属性设置方法
     * fontSize              文字大小, 默认15
     * placeholder           占位符
     * max            最大输入位数
     * textColor             文字颜色, 默认黑色
     * placeholderColor      占位符颜色, 默认浅灰
     * maxColor        最多文字颜色, 默认浅灰
     * TextChange      文本改变回调
     * textEndEditing  文本结束编辑回调
     */
//    func set(fontSize: CGFloat?, placeholder: String?, max: Int?, textColor: UIColor?, placeholderColor: UIColor?, maxColor: UIColor?, textChange:TextChange, textEndEditing: TextEndEditing) {
//        backgroundColor = .color238238238
//        addSubview(textView)
//        addSubview(textPlView)
//        addSubview(maxNumLabel)
//
//        textView.snp.makeConstraints { (make) in
//            make.left.top.equalTo(5)
//            make.right.bottom.equalTo(-5)
//        }
//
//        textPlView.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalTo(textView)
//        }
//
//        maxNumLabel.snp.makeConstraints { (make) in
//            make.right.bottom.equalTo(-11)
//        }
//
//        textView.textColor = textColor
//        textView.delegate = self
//        // 文本改变
//        textView.textChange {[weak self] (str) in
//            var text = str
//            self?.textPlView.isHidden = text.count != 0 ? true: false
//            // 未超过最大值
//            if let max = max, text.count <= max {
//                self?.maxNumLabel.text = "\(text.count)/\(max)"
//            }
//            // 超过最大值截取
//            if self?.textView.markedTextRange == nil, let max = max, text.count > max {
//                text = String(text.prefix(max))
//                self?.textView.text = text
//                self?.maxNumLabel.text = "\(max)/\(max)"
//            }
//
//            guard let block = textChange else {
//                return
//            }
//            block(text)
//        }
//
//        textView.textDidEndEditing(type: self) { (str) in
//            guard let block = textEndEditing else {
//                return
//            }
//            block(str)
//        }
//
//        textPlView.text = placeholder
//        textPlView.textColor = placeholderColor ?? .lightGray
//
//        maxNumLabel.textColor = maxColor ?? .lightGray
//        guard let max = max else {
//            return maxNumLabel.isHidden = true
//        }
//        maxNumLabel.text = "0/\(max)"
//    }
     
    
    lazy var textView: UITextView = {
        let textView = UITextView.init()
        textView.backgroundColor = .clear
        textView.delegate = self
        textView.textColor = textColor
        textView.font = UIFont.systemFont(ofSize: fontSize)
        
        return textView
    }()
    
    private lazy var textPlView: UITextView = {
        let textView = UITextView.init()
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = .clear
        textView.text = placeholder
        textView.textColor = placeholderColor
        textView.font = UIFont.systemFont(ofSize: fontSize)
        return textView
    }()
    
    private lazy var maxNumLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = .right
        label.isHidden = true
        label.textColor = maxCountColor
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }()
}

extension ZWTextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        var text = textView.text ?? ""
        textPlView.isHidden = text.count != 0 ? true: false
        // 未超过最大值
        if let max = maxCount, text.count <= max {
            maxNumLabel.text = "\(text.count)/\(max)"
        }
        // 超过最大值截取
        if textView.markedTextRange == nil, let max = maxCount, text.count > max {
            text = String(text.prefix(max))
            textView.text = text
            maxNumLabel.text = "\(max)/\(max)"
        }

        guard let block = textChange else {
            return
        }
        block(text)
        
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        let text = textView.text ?? ""
        guard let block = textEndEditing else {
            return
        }
        block(text)
    }
              
              
}


