//  Monang Champaneri
//
//  Created by Monang Champaneri
//

import UIKit

@IBDesignable class MNTextField: UITextField {
    
    let animationDuration = 0.3
    var title = UILabel()
    var bottomBorder: UIView?
    var leftimageview : UIImageView?
    var rightimageview : UIImageView?
    // MARK:- Properties
    override var accessibilityLabel:String? {
        get {
            if let txt = text , txt.isEmpty {
                return title.text
            } else {
                return text
            }
        }
        set {
            self.accessibilityLabel = newValue
        }
    }
    
    override var placeholder:String? {
        didSet {
            title.text = placeholder
            title.sizeToFit()
        }
    }
    
    override var attributedPlaceholder:NSAttributedString? {
        didSet {
            title.text = attributedPlaceholder?.string
            title.sizeToFit()
        }
    }
    
    var titleFont:UIFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            title.font = titleFont
            title.sizeToFit()
        }
    }
    @IBInspectable open var leftImage : UIImage? {
        didSet {
            if leftImage != nil {
                let width = leftviewWidth > leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
                leftViewMode = .always
                leftimageview = UIImageView();
                leftimageview!.frame = CGRect(x: self.frame.origin.x+10,y: self.frame.origin.y+2,width: width,height: self.frame.size.height-4)
                leftimageview!.image = leftImage;
                leftView = leftimageview;
                self.leftViewMode = .always
                leftimageview!.contentMode = .center
            }
            
        }
    }
    @IBInspectable open var leftviewWidth : CGFloat = 0 {
        didSet{
            if leftimageview != nil{
                let width = leftviewWidth > leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
                leftimageview!.frame = CGRect(x: self.frame.origin.x+10,y: self.frame.origin.y+2,width: width,height: self.frame.size.height-4)
            }
        }
    }
    @IBInspectable open var rightImage : UIImage? {
        didSet {
            if rightImage != nil {
                let width = rightviewWidth > rightImage!.size.width + 10 ? rightviewWidth :  rightImage!.size.width + 10
                rightViewMode = .always
                rightimageview = UIImageView()
                rightimageview!.frame=CGRect(x: self.frame.size.width - width,y: self.frame.origin.y+2,width: width,height: self.frame.size.height-4)
                rightimageview!.image = rightImage
                rightView = rightimageview
                self.rightViewMode = .always
                rightimageview!.contentMode = .center
            }
        }
    }
    @IBInspectable open var rightviewWidth : CGFloat = 0 {
        didSet{
            if rightimageview != nil{
                let width = rightviewWidth > rightImage!.size.width + 10 ? rightviewWidth :  rightImage!.size.width + 10
                rightimageview!.frame=CGRect(x: self.frame.origin.x+5,y: self.frame.origin.y+2,width: width, height: self.frame.size.height-4)
            }
        }
    }
    
    @IBInspectable var hintYPadding:CGFloat = 0.0
    @IBInspectable var titleYPadding:CGFloat = 0.0 {
        didSet {
            var r = title.frame
            r.origin.y = titleYPadding
            title.frame = r
        }
    }
    
    @IBInspectable var titleTextColour:UIColor = UIColor.black {
        didSet {
            if !isFirstResponder {
                title.textColor = titleTextColour
            }
        }
    }
    
    @IBInspectable open var bottomBorderColor : UIColor = UIColor.clear {
        didSet {
            bottomBorder?.backgroundColor = bottomBorderColor
        }
    }
    @IBInspectable open var bottomBorderHeight : CGFloat = 0 {
        didSet{
            if bottomBorder == nil{
                bottomBorder = UIView()
                addSubview(bottomBorder!)
            }
            bottomBorder?.backgroundColor = bottomBorderColor
            bottomBorder?.frame = CGRect(x: 0,y: self.frame.size.height - bottomBorderHeight,width: self.frame.size.width,height: bottomBorderHeight)
        }
    }
    
    
    @IBInspectable var titleActiveTextColour:UIColor! {
        didSet {
            if isFirstResponder {
                title.textColor = titleActiveTextColour
            }
        }
    }
    
    // MARK:- Init
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    // MARK:- Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomBorder?.frame = CGRect(x: 0,y: self.frame.size.height - bottomBorderHeight,width: self.frame.size.width,height: bottomBorderHeight)
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder
        if let txt = text , !txt.isEmpty && isResp {
            title.textColor = titleActiveTextColour
        } else {
            title.textColor = titleTextColour
        }
        // Should we show or hide the title label?
        if let txt = text , txt.isEmpty {
            // Hide
            hideTitle(isResp)
        } else {
            // Show
            showTitle(isResp)
        }
    }
    
    override func textRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.textRect(forBounds: bounds)
        if let txt = text , !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = r.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return r.integral
    }
    
    override func editingRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.editingRect(forBounds: bounds)
        if let txt = text , !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = r.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return r.integral
    }
    
    override func clearButtonRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.clearButtonRect(forBounds: bounds)
        if let txt = text , !txt.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = CGRect(x:r.origin.x, y:r.origin.y + (top * 0.5), width:r.size.width, height:r.size.height)
        }
        return r.integral
    }
    
    // MARK:- Public Methods
    
    // MARK:- Private Methods
    fileprivate func setup() {
        
        borderStyle = .none
        titleActiveTextColour =  UIColor.black
        //tintColor
        // Set up title label
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = titleTextColour
        if let str = placeholder , !str.isEmpty {
            title.text = str
            title.sizeToFit()
        }
        self.addSubview(title)
    }
    
    fileprivate func maxTopInset()->CGFloat {
        if let fnt = font {
            return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
        }
        return 0
    }
    
    fileprivate func setTitlePositionForTextAlignment() {
        let r = textRect(forBounds: bounds)
        var x = r.origin.x
        if textAlignment == NSTextAlignment.center {
            x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
        } else if textAlignment == NSTextAlignment.right {
            x = r.origin.x + r.size.width - title.frame.size.width
        }
        title.frame = CGRect(x:x, y:title.frame.origin.y, width:title.frame.size.width, height:title.frame.size.height)
    }
    
    fileprivate func showTitle(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut], animations:{
            // Animation
            self.title.alpha = 1.0
            var r = self.title.frame
            r.origin.y = self.titleYPadding
            self.title.frame = r
        }, completion:nil)
    }
    
    fileprivate func hideTitle(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseIn], animations:{
            // Animation
            self.title.alpha = 0.0
            var r = self.title.frame
            r.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = r
        }, completion:nil)
    }
}

