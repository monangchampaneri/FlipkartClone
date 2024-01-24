//  Monang Champaneri
//
//  Created by Monang Champaneri
//

import UIKit

class MNView: UIView {

    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            if UIDevice.current.userInterfaceIdiom == .pad{
                layer.cornerRadius = cornerRadius * 2
            }else{
                layer.cornerRadius = cornerRadius
            }
            
        }
    }  
    @IBInspectable var topCornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
            self.clipsToBounds = true
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    @IBInspectable var isRounded: Bool = false {
        didSet{
            if isRounded == true{
                layer.cornerRadius = self.frame.size.width/2
            }else{
                layer.cornerRadius = cornerRadius
            }
        }
    }
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet{
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.masksToBounds = false
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0{
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet{
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
