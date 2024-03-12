//
//  UIImage+Extension.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/13.
//

import Foundation
import UIKit

public extension UIImage{
    convenience init(designed: String) {
        self.init(named: designed, in: Bundle.current, with: .none)!
    }
}
