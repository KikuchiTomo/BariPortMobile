//
//  BariPortAPIClient.swift
//  BariPortAPI
//
//  Created by Tomo Kikuchi on 2024/03/23.
//

import Foundation
import Alamofire

public class BariPortAPIClient{
    typealias U = BariPortAPIClient
    private init(){}
    
    // TODO: スマートに書くための関数. もっといい書き方あったら教えてください🙇‍♂️. static関数にするとアクセスが遅すぎるのでこうする
    fileprivate func withUnwrapOptional<T>(_ data: T?, _ error: Error?, _ config:  CheckedContinuation<T, Error>){
        if let error = error{
            config.resume(throwing: error)
        }else if let data = data{
            config.resume(returning: data)
        }else{
            config.resume(throwing: BariPortAPIErrors.NilResponse)
        }
    }
    
    public static func getHello() async throws -> Hello{
        return try await withCheckedThrowingContinuation{ config in
            V1API.hello{ data, error in
                U().withUnwrapOptional(data, error, config)
            }
        }
    }
    
    public static func getProjects() async throws -> [Projects]{
        return try await withCheckedThrowingContinuation{ config in
            V1API.getProjects{ data, error in
                U().withUnwrapOptional(data, error, config)
            }
        }
    }
    
    public static func getReviews() async throws -> [Reviews]{
        return try await withCheckedThrowingContinuation{ config in
            V1API.getReviews{ data, error in
                U().withUnwrapOptional(data, error, config)
            }
        }
    }
    
    public static func getMessages(chatRoomID: String) async throws -> [MessagesGet]{
        return try await withCheckedThrowingContinuation{ config in
            V1API.getMessages(chatRoomId: chatRoomID){ data, error in
                U().withUnwrapOptional(data, error, config)
            }
        }
    }
   
    public static func getChatRooms(projectID: String) async throws -> [ChatRooms]{
        return try await withCheckedThrowingContinuation{ config in
            V1API.getChatRooms(projectId: projectID){ data, error in
                U().withUnwrapOptional(data, error, config)
            }
        }
    }
    
    public static func postChatRoomParticipants(
        name: String,
        description: String,
        companyName: String) async throws {
        return try await withCheckedThrowingContinuation{ config in
            // TODO: なんかおかしい!?!?!?. yamlが間違っている可能性大かも？！？！？
            // チャットルームへの参加にUserIDないのはなんかおかしい気がする
            V1API.postChatRoomParticipants(
                body: .init(
                    chatRooom:
                            .init(name: name,
                                  _description: name,
                                  company:
                                    .init(
                                        name: companyName)
                                 ))
            ){ data, error in
                U().withUnwrapOptional(data, error, config)
            }
        }
    }
     
    public static func postMessage(
        userID: String,
        chatRoomID: String,
        message: String,
        sendAt: Date) async throws {
        // TODO: SendAtの形式がわからないので聞く
        // UTCなのかどうか, YYYY-MM-DD'T'HH:mm:ss.SSSZZZZZ なのかどうか
        return try await withCheckedThrowingContinuation{ config in
            V1API.postMessage(
                body: .init(
                    userId: userID,
                    chatRoomId: chatRoomID,
                    text: message,
                    sendAt: sendAt.bariPortFormatString()
                )
            ){ data, error in
                U().withUnwrapOptional(data, error, config)
            }
        }
    }
}

public extension String{
    func parseFromBariPortFormat() -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        // Localにする場合:
        // formatter.locale = .current
        // 日本固定:
        formatter.locale = Locale(identifier: "ja_JP")
        
        // とりあえずUTCで返しておく
        return formatter.date(from: self)
    }
}

public extension Date{
    func bariPortFormatString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        // Localにする場合:
        // formatter.locale = .current
        // 日本固定:
        formatter.locale = Locale(identifier: "ja_JP")
        
        // とりあえずUTCで返しておく
        return formatter.string(from: self)
    }
}
