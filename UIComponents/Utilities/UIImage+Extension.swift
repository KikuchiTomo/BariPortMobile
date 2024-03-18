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
    
    convenience init(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)!
            return
        } catch let err {
            // TODO: Error handling
        }
        self.init()
    }
}
