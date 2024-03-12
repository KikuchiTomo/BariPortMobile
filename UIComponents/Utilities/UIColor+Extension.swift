//
//  UIColor+Extension.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/13.
//

import Foundation
import UIKit

public extension UIColor{
    convenience init(designed: String){
        self.init(named: designed, in: Bundle.current, compatibleWith: .none)!
    }
}
