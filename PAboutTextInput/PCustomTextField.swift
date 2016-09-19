//
//  PCustomTextField.swift
//  PAboutTextInput
//
//  Created by 邓杰豪 on 2016/9/19.
//  Copyright © 2016年 邓杰豪. All rights reserved.
//

enum PCAnimationType : Int {
    case UpDown
    case LeftRight
    case BlowUp
    case EasyInOut
    case None
}

import UIKit

class PCustomTextField: UITextField {
    var normalColor:UIColor?
    var selectedColor:UIColor?
    var getAnimationType:PCAnimationType?
    var lineColor:UIColor?

    convenience init() {
        self.init()
        self.backgroundColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 14)
        self.borderStyle = .roundedRect
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let lineView = UIView.init(frame: CGRect.init(x: 0, y: self.frame.size.height - 2, width: self.frame.size.width, height: 2))
        lineView.backgroundColor = self.lineColor
        self.addSubview(lineView)
    }

    func getPlaceholderLabel()->UILabel
    {
        return self.value(forKey: "placeholderLabel") as! UILabel
    }

    func getDisplayLabel()->UILabel
    {
        return self.value(forKey: "displayLabel") as! UILabel
    }

    func doAnimationWithType(getAnimationType:PCAnimationType,label:UILabel)
    {
        switch getAnimationType {
        case .UpDown:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                label.transform = CGAffineTransform.init(translationX: 0, y: 10)
                }, completion: { (finish:Bool) in
            })
            break
        case .LeftRight:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                label.transform = CGAffineTransform.init(translationX: 10, y: 0)
                }, completion: { (finish:Bool) in
            })
            break
        case .BlowUp:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                label.transform = CGAffineTransform.init(translationX: 1.2, y: 1.2)
                }, completion: { (finish:Bool) in
            })
            break
        case .EasyInOut:
            UIView.animate(withDuration: 0.5, animations: { 
                label.alpha = 0.4
            })
            break
        case .None:
            break
        }
    }

    func displayLableDoAnimationWithType(getAnimationType:PCAnimationType)
    {
        doAnimationWithType(getAnimationType: getAnimationType, label: getDisplayLabel())
        getDisplayLabel().transform = CGAffineTransform.identity
    }

    func placeholderLabelDoAnimationWithType(getAnimationType:PCAnimationType)
    {
        doAnimationWithType(getAnimationType: getAnimationType, label: getPlaceholderLabel())
    }

    override func becomeFirstResponder() -> Bool {
        if self.normalColor == nil
        {
            self.normalColor = self.getPlaceholderLabel().textColor
        }
        if self.selectedColor == nil
        {
            self.selectedColor = self.getPlaceholderLabel().textColor
        }

        self.getPlaceholderLabel().textColor = self.selectedColor
        placeholderLabelDoAnimationWithType(getAnimationType: self.getAnimationType!)
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        if self.getAnimationType == .UpDown
        {
            getPlaceholderLabel().transform = CGAffineTransform.identity
        }
        else if self.getAnimationType == .LeftRight
        {
            getPlaceholderLabel().transform = CGAffineTransform.identity
        }
        else if self.getAnimationType == .BlowUp
        {
        }
        else if self.getAnimationType == .EasyInOut
        {
            UIView.animate(withDuration: 0.5, animations: { 
                self.getPlaceholderLabel().alpha = 1
            })
        }
        getPlaceholderLabel().textColor = self.normalColor
        return super.resignFirstResponder()
    }
}
