//
//  UIImage+Exntesion.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/13.
//

import Foundation
import UIKit

public extension UIImage{   
    struct Common{
        public static var directMessage: UIImage{
            UIImage(designed: "direct_message")
        }
        
        public static var floatRing: UIImage{
            UIImage(designed: "float_ring")
        }
        
        public static var home: UIImage{
            UIImage(designed: "home")
        }
        
        public static var Star: UIImage{
            UIImage(systemName: "star")!
        }
        
        public static var StarFill: UIImage{
            UIImage(systemName: "star.fill")!
        }
        
        public static var logout: UIImage{
            UIImage(designed: "logout")
                .resize(size: .init(width: 20, height: 20))!
        }
    }
    
     /* Features 単位で構造体定義 */
    struct Account{
        public static var VisibleEyeOpen: UIImage{
            UIImage(systemName: "eye.fill")!
            
            // TODO: デザインされたアイコンに入れ替える
            // UImage(designed: "{asset name}")
        }
        
        public static var Logo: UIImage{
            UIImage(designed: "kitaq_logo")
                .resize(size: .init(width: 50, height: 50))!
                .withRenderingMode(.alwaysTemplate)
        }
    }
    
    struct Messages{
        public static var NoImageUser: UIImage{
            UIImage(systemName: "person.circle.fill")!
        }
    }
    
    struct Support{
       
    }
}
