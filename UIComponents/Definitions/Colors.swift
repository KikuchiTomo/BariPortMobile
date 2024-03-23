//
//  Colors.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/13.
//

import Foundation
import UIKit

public extension UIColor{
    // 例：
    static var primary: UIColor{
        UIColor(designed: "primary")
        // TODO: デザインされたカラーに入れ替える
        // UIColor(designed: "{asset name}")
    }
    
    static var secondary: UIColor{
        UIColor(designed: "secondary")
    }
    
    static var error: UIColor{
        UIColor(designed: "error")
    }
}
