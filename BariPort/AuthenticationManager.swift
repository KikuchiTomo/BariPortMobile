//
//  AuthenticationManager.swift
//  BariPort
//
//  Created by Tomo Kikuchi on 2024/03/23.
//

import Foundation

// TODO: 現在はサーバ側に認証機能ないのでこれでOK
class AuthenticationManager{
    public static let shared: AuthenticationManager = .init()
    
    private init() { }
    
    public var userID = UUID().uuidString
    
    enum Status{
        case logined
        case noLogin
    }
    
    public var state: Status = .noLogin
}
