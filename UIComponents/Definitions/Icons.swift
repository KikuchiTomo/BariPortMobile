//
//  UIImage+Exntesion.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/13.
//

import Foundation
import UIKit

public extension UIImage{
    /* Features 単位で構造体定義 */
    struct Account{
        public static var VisibleEyeOpen: UIImage{
            UIImage(systemName: "eye.fill")!
            
            // TODO: デザインされたアイコンに入れ替える
            // UImage(designed: "{asset name}")
        }
    }
}
