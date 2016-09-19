//
//  PSearchBar.swift
//  PAboutTextInput
//
//  Created by 邓杰豪 on 2016/9/19.
//  Copyright © 2016年 邓杰豪. All rights reserved.
//

import UIKit

class PSearchBar: UISearchBar {
    var searchPlaceholder:NSString?
    var searchPlaceholderFont:UIFont?
    var searchPlaceholderColor:UIColor?
    var searchTextColor:UIColor?
    var searchTextFieldBackgroundColor:UIColor?
    var searchBarImage:UIImage?
    var searchBarOutViewColor:UIColor?
    var searchBarTextFieldBorderColor:UIColor?
    var searchBarTextFieldBorderWidth:CGFloat?
    var searchBarTextFieldCornerRadius:CGFloat?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tintColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var searchField:UITextField?
        let subViewArr:NSArray?
        subViewArr = self.subviews as NSArray?

        for i in 0 ..< Int((subViewArr?.count)!)
        {
            let viewSub:UIView? = subViewArr?.object(at: i) as? UIView
            let arrSub:NSArray? = viewSub?.subviews as NSArray?
            for j in 0 ..< Int((subViewArr?.count)!)
            {
                let tempId:UITextField? = arrSub?.object(at: j) as! UITextField?
                searchField = tempId
            }
        }

        if searchField != nil
        {
            searchField?.placeholder = self.searchPlaceholder as String?
            searchField?.borderStyle = .roundedRect
            searchField?.backgroundColor = self.searchTextFieldBackgroundColor
            searchField?.attributedPlaceholder = NSAttributedString.init(string: self.searchPlaceholder as! String, attributes: [NSFontAttributeName:self.searchPlaceholderFont,NSForegroundColorAttributeName:self.searchPlaceholderColor])
            searchField?.textColor = self.searchTextColor
            searchField?.font = self.searchPlaceholderFont
            searchField?.layer.borderColor = self.searchBarTextFieldBorderColor?.cgColor
            searchField?.layer.borderWidth = self.searchBarTextFieldBorderWidth!
            searchField?.layer.cornerRadius = self.searchBarTextFieldCornerRadius!

            let iView = UIImageView.init(image: self.searchBarImage)
            iView.frame = CGRect.init(x: 0, y: 0, width: 16, height: 16)
            searchField?.leftView = iView
        }

        let outView = UIView.init(frame: self.bounds)
        outView.backgroundColor = self.searchBarOutViewColor!
        self.insertSubview(outView, at: 1)
    }
}
