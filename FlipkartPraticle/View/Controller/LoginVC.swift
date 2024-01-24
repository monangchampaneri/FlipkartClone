//
//  LoginVC.swift
//  FlipkartPraticle
//
//  Created by Monang Champaneri on 23/01/24.
//

import UIKit
import FlagPhoneNumber

enum inputTypeforLogin{
    case email
    case mobilenumber
}

class LoginVC: UIViewController {

    @IBOutlet weak var txtPhoneNumber: FPNTextField!
    @IBOutlet weak var txtEmailID: MNTextField!
    
    @IBOutlet weak var lblTerms_Privacy: UILabel!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var nsContinueButtton: NSLayoutConstraint!
    
    var typeInput:inputTypeforLogin = .mobilenumber
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    
        // Do any additional setup after loading the view.
        
    }

    @IBAction func OnTapEmailToPhone(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.viewEmail.isHidden = sender.isSelected ? false : true
        self.viewPhone.isHidden = sender.isSelected ? true : false
        typeInput = sender.isSelected ? .email : .mobilenumber
        sender.isSelected  ? txtEmailID.becomeFirstResponder() : txtPhoneNumber.becomeFirstResponder()
    }
    
    @IBAction func OnTapContinue(_ sender: UIButton) {
        if sender.isEnabled{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
            vc.otpSendValue = typeInput == .email ? self.txtEmailID.text! : "\(self.txtPhoneNumber.selectedCountry!.phoneCode) \(self.txtPhoneNumber.text!)"
                    self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension LoginVC{
    func setupUI()  {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        self.txtEmailID.delegate = self
        self.txtPhoneNumber.delegate = self
        
        btnContinue.backgroundColor = .lightGray
        
        let text = "By continuing, you agree to Flipkart's Terms of Use and Privacy Policy"
        lblTerms_Privacy.text = text
        self.lblTerms_Privacy.textColor =  UIColor.black
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Terms of Use")
        let range2 = (text as NSString).range(of: "Privacy Policy")
             underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: range1)
             underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "primaryBlueColor")!, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "primaryBlueColor")!, range: range2)
        lblTerms_Privacy.attributedText = underlineAttriString
        lblTerms_Privacy.isUserInteractionEnabled = true
        lblTerms_Privacy.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))

    }
}

extension LoginVC{
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (self.lblTerms_Privacy.text! as NSString).range(of: "Terms & Conditions")
    // comment for now
        let privacyRange = (self.lblTerms_Privacy.text! as NSString).range(of: "Privacy Policy")

    if gesture.didTapAttributedTextInLabel(label: lblTerms_Privacy, inRange: termsRange) {
        print("Tapped terms")
    } else if gesture.didTapAttributedTextInLabel(label: lblTerms_Privacy, inRange: privacyRange) {
        print("Tapped privacy")
    } else {
        print("Tapped none")
    }
    }
}

extension LoginVC:UITextFieldDelegate,FPNTextFieldDelegate{
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        
    }
    
    func fpnDidValidatePhoneNumber(textField: FlagPhoneNumber.FPNTextField, isValid: Bool) {
        if isValid{
            self.btnContinue.isEnabled = true
            self.btnContinue.backgroundColor = UIColor(named: "primaryBlueColor")!
        }else{
            self.btnContinue.isEnabled = false
            self.btnContinue.backgroundColor = .lightGray
        }
    }
    
    func fpnDisplayCountryList() {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if typeInput == .email{
            if (self.txtEmailID.text!.isValidEmail == true){
                self.btnContinue.isEnabled = true
                self.btnContinue.backgroundColor = UIColor(named: "primaryBlueColor")!
            }else{
                self.btnContinue.isEnabled = false
                self.btnContinue.backgroundColor = .lightGray
            }
        }else{
            if (self.txtPhoneNumber.text!.isValidPhone == true){
                self.btnContinue.isEnabled = true
                self.btnContinue.backgroundColor = UIColor(named: "primaryBlueColor")!
            }else{
                self.btnContinue.isEnabled = false
                self.btnContinue.backgroundColor = .lightGray
            }
        }
      
        return true
    }
}
extension LoginVC{
   @objc func keyboardWillShow(notification: NSNotification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if nsContinueButtton.constant <= 16{
                let height = keyboardSize.height + 40

                nsContinueButtton.constant += height
               }

           }

       }

    @objc func keyboardWillHide(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               if nsContinueButtton.constant != 16 {
                   nsContinueButtton.constant = 16
               }

           }
       }
}
extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
