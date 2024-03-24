//
//  UIViewController+Extension.swift
//  BariPort
//
//  Created by Tomo Kikuchi on 2024/03/18.
//

import Foundation
import UIKit

extension UIViewController{
    /// 自身をRootにした UINavigationController を返す
    /// - Returns: UINavigationController(rootViewController: self)
    func generatedRootNavigationController() -> UINavigationController{
        let navVC = UINavigationController(rootViewController: self)
        return navVC
    }
    
    /// 自身をRootにした UINavigationController を返す
    /// - Parameter title: NavigationBarのタイトルを設定する
    /// - Returns: UINavigationController(rootVie   Controller: self)
    func generatedRootNavigationController(title: String) -> UINavigationController{
        self.title = title
        let navVC = UINavigationController(rootViewController: self)
        return navVC
    }
    
    func setNavLeftButton(_ button: UIBarButtonItem) {
        self.navigationItem.leftBarButtonItems = self.createBarButtonItemsForEachOS(button: button)
    }
    
    func setNavRightButton(_ button: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItems = self.createBarButtonItemsForEachOS(button: button)
    }
      
    private func createBarButtonItemsForEachOS(button: UIBarButtonItem) -> [UIBarButtonItem] {
        if #available(iOS 11, *) {
            return [self.createSpacer(), button]
        } else {
            return [button]
        }
    }
    
    private func createSpacer() -> UIBarButtonItem {
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 8 
        return spacer
    }
}
