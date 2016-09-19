//
//  PTextView.swift
//  PAboutTextInput
//
//  Created by 邓杰豪 on 2016/9/19.
//  Copyright © 2016年 邓杰豪. All rights reserved.
//

import UIKit

class PTextView: UITextView {
    var placeholder:NSString?
    var realTextColor:UIColor?

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        awakeFromNib()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        NotificationCenter.default.addObserver(self, selector: #selector(beginEditing(notification:)), name: NSNotification.Name.UITextViewTextDidBeginEditing, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(endEditing(notification:)), name: NSNotification.Name.UITextViewTextDidBeginEditing, object: self)

        self.realTextColor = UIColor.black
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setPlaceholder(aPlaceholder:String)
    {
        if  (realText().isEqual(to: self.placeholder as! String))
        {
            self.text = aPlaceholder
        }
        self.placeholder = aPlaceholder as NSString?
        let noti = NSNotification.init()
        endEditing(notification: noti)
    }

    override var text:String!
    {
        get
        {
            return super.text
        }
        set
        {
            if (text as NSString).isEqual(to: self.placeholder as! String)
            {
                super.text = ""
            }
        }
    }

    func setText(text:NSString)
    {
        if text.isEqual(to: "") || text.length == 0
        {
            super.text = self.placeholder as! String
        }
        else
        {
            super.text = text as String
        }

        if text.isEqual(to: self.placeholder as! String)
        {
            self.textColor = UIColor.lightGray
        }
        else
        {
            self.textColor = self.realTextColor
        }
    }

    func realText()->NSString
    {
        return (super.text as NSString)
    }

    func beginEditing(notification:NSNotification)
    {
        if  (realText().isEqual(to: self.placeholder as! String))
        {
            super.text = nil
            self.textColor = self.realTextColor
        }
    }

    func endEditing(notification:NSNotification)
    {
        if realText().isEqual(to: "") || realText().length == 0
        {
            self.text = self.placeholder as String!
            self.textColor = UIColor.lightGray
        }
    }

    func setTextColor(textColor:UIColor)
    {
        if  (realText().isEqual(to: self.placeholder as! String))
        {
            if textColor.isEqual(UIColor.lightGray)
            {
                super.textColor = textColor
            }
            else
            {
                self.realTextColor = textColor
            }
        }
        else
        {
            self.realTextColor = textColor
            super.textColor = textColor
        }
    }
}
