//
//  Switcher.swift
//  BariPort
//
//  Created by 渡辺大智 on 2024/03/23.
//

import Foundation
import UIKit

protocol TabSwitcher: AnyObject {
    func tabSwitch(to tab: Int)
}

class Switcher {
    static let shared = Switcher()
    
    weak var tabHostViewController: TabSwitcher?
    
    private init() {}
    
    func tabSwitch(to tab: Int) {        
        tabHostViewController?.tabSwitch(to: tab)
    }
}
