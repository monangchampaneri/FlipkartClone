//
//  Valiadation.swift
//  FlipkartPraticle
//
//  Created by Monang Champaneri on 24/01/24.
//

import Foundation
import UIKit

extension String {
   var isValidEmail: Bool {
      let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
      let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
      return testEmail.evaluate(with: self)
   }
   var isValidPhone: Bool {
      let regularExpressionForPhone = "[235689][0-9]{6}([0-9]{3})?"
      let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
      return testPhone.evaluate(with: self)
   }
}
