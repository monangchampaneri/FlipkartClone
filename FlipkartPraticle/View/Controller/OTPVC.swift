//
//  OTPVC.swift
//  FlipkartPraticle
//
//  Created by Monang Champaneri on 24/01/24.
//

import UIKit
import OTPFieldView

class OTPVC: UIViewController {

    @IBOutlet weak var lblDescText: UILabel!
    @IBOutlet weak var otpView: OTPFieldView!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var nsVerifyButtton: NSLayoutConstraint!
    var otpSendValue:String = ""
    var countdownTimer: Timer!
    var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }

    @IBAction func OnTapVerify(_ sender: UIButton) {
        if sender.isEnabled{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
                    self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func OnTapResend(_ sender: UIButton) {
        self.startTimer()
        sender.isEnabled = false
    }
    @IBAction func OnTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension OTPVC{
    
    func setupUI(){
        self.startTimer()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.otpView.defaultBorderColor = .lightGray
        self.otpView.filledBorderColor = UIColor(named: "primaryBlueColor")!
        self.otpView.cursorColor = UIColor(named: "primaryBlueColor")!
        self.otpView.displayType = .underlinedBottom
        self.otpView.delegate = self
        self.otpView.fieldsCount = 6
        self.otpView.fieldBorderWidth = 2
        self.otpView.fieldSize = 40
        self.otpView.separatorSpace = 8
        self.otpView.shouldAllowIntermediateEditing = false
        self.otpView.initializeUI()
        let text = "Please enter the verification code we've sent you on \(otpSendValue) Edit"
        lblDescText.text = text
        self.lblDescText.textColor =  UIColor.black
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Edit")
    
             underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14), range: range1)
             underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "primaryBlueColor")!, range: range1)
   
        lblDescText.attributedText = underlineAttriString
        lblDescText.isUserInteractionEnabled = true
        lblDescText.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
}
extension OTPVC{
   @objc func keyboardWillShow(notification: NSNotification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if nsVerifyButtton.constant <= 16{
                let height = keyboardSize.height + 40
                nsVerifyButtton.constant += height
                
               }

           }

       }

    @objc func keyboardWillHide(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               if nsVerifyButtton.constant != 16 {
                    nsVerifyButtton.constant = 16
               }

           }
       }
}
extension OTPVC{
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let editRange = (self.lblDescText.text! as NSString).range(of: "Edit")
    if gesture.didTapAttributedTextInLabel(label: lblDescText, inRange: editRange) {
        self.navigationController?.popViewController(animated: true)
    }
}
}
extension OTPVC{
    func startTimer() {
           countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
       }
    @objc func updateTime() {
        self.btnResend.setTitle("\(timeFormatted(totalTime))", for: .disabled)
            if totalTime != 0 {
                totalTime -= 1
            } else {
                endTimer()
            }
        }
    func endTimer() {
            btnResend.isEnabled = true
           countdownTimer.invalidate()
           totalTime = 60
       }

       func timeFormatted(_ totalSeconds: Int) -> String {
           let seconds: Int = totalSeconds % 60
           let minutes: Int = (totalSeconds / 60) % 60
           //     let hours: Int = totalSeconds / 3600
           return String(format: "%02d:%02d", minutes, seconds)
       }
}
extension OTPVC : OTPFieldViewDelegate{
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        if otp == "123456"{
            
        }
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        if hasEnteredAll{
            self.btnVerify.isEnabled = true
            self.btnVerify.backgroundColor = UIColor(named: "primaryBlueColor")!
        }else{
            self.btnVerify.isEnabled = false
            self.btnVerify.backgroundColor = .lightGray
        }
        return true
    }
    
    
}
