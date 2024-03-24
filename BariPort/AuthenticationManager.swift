//
//  AuthenticationManager.swift
//  BariPort
//
//  Created by Tomo Kikuchi on 2024/03/23.
//

import Foundation
import FirebaseAuth

// TODO: 現在はサーバ側に認証機能ないのでこれでOK
extension Notification.Name{
    static let FirebaseAuthStateDidChanged = Notification.Name("FirebaseAuthNotificationKeyName")
}

class AuthenticationManager{
    enum Status{
        case logined
        case noLogin
    }
    
    public static let shared: AuthenticationManager = .init()
        
    private var currentUser: User? = nil
    private var isAnonymous: Bool = false
    
    private init() {
        // Firebaseでの認証状態が変わったらNCで通知する
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let currentUser = user {
                self.currentUser = currentUser
                self.isAnonymous = currentUser.isAnonymous
            } else {
                self.currentUser = nil
                self.isAnonymous = false
            }
            
            NotificationCenter.default.post(name: .FirebaseAuthStateDidChanged, object: nil)
        })
        
        // 起動直後に更新
        self.currentUser = Auth.auth().currentUser
        if let user = self.currentUser{
            self.isAnonymous = user.isAnonymous
        }
    }
    
    public var userID: String?{
        get{
            return self.currentUser?.uid
        }
    }
    
    public var displayName: String?{
        get{
            return self.currentUser?.displayName
        }
    }
    
    public var displayEmail: String?{
        get{
            return self.currentUser?.email
        }
    }
    
    public var state: Status {
        get{
            guard currentUser != nil else { return .noLogin}
            return .logined
        }
    }
    
    public func signUp(email: String, password: String) async throws -> AuthDataResult{
        return try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    public func signIn(email: String, password: String) async throws -> AuthDataResult{
        return try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    public func signOut() throws {
        try Auth.auth().signOut()
    }
    
    public func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
