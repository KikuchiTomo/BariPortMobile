//
//  Bundle+Extension.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/13.
//

import Foundation

extension Bundle{
    static var current: Bundle{
        class BundleDummyClass{}
        return Bundle(for: type(of: BundleDummyClass()))
    }
}
