//
//  UIView+Extension.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/23.
//

import Foundation
import UIKit

extension UIView {
    func addVisualEffect() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        let blurEffect = UIBlurEffect(style: .dark)

        let visualEffectView = UIVisualEffectView(effect: blurEffect)

        visualEffectView.frame = CGRect(x: 0, y: 0, width: width, height: height)

        self.addSubview(visualEffectView)
        self.sendSubviewToBack(visualEffectView)
    }
}
