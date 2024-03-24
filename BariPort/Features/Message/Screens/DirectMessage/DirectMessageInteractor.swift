import Foundation
import UIKit
import BariPortAPI

protocol DirectMessageUsecase: AnyObject {
    
    // example
    // このAPIがどこからとってきたものなのかは気にしない. そのため返す方はEntityで定義されたものに変換する
    func fetchHello() async throws -> DirectMessageEntity.Hello?
    func fetchMessages(chatRoomID: String, loginUserId: String) async throws -> [DirectMessageEntity.Message]
    func postMessage(chatRoomID: String, userID: String, message: String) async throws
}

final class DirectMessageInteractor: DirectMessageUsecase{
    init(){}
        
    func fetchHello() async throws -> DirectMessageEntity.Hello? {
        let result = try await BariPortAPIClient.getHello()
        return result.convert()
    }
    
    func fetchMessages(chatRoomID: String, loginUserId: String) async throws -> [DirectMessageEntity.Message] {
        return try await BariPortAPIClient.getMessages(chatRoomID: chatRoomID, loginUserId: loginUserId).map{
            $0.convert()
        }
    }
    
    func postMessage(chatRoomID: String, userID: String, message: String) async throws {
        try await 
        BariPortAPIClient.postMessage(userID: userID, chatRoomID: chatRoomID, message: message)
    }
}

extension BariPortAPI.Result{
    func convert() -> Bool{
        guard let message = self.message else { return false }
        return (message == "success")
    }
}

extension BariPortAPI.Hello{
    func convert() -> DirectMessageEntity.Hello?{
        guard let message = self.message else { return nil }
        return .init(message: message)
    }
}

extension BariPortAPI.MessagesGet{
    func convert() -> DirectMessageEntity.Message{
        // TODO: これもなんか定義がおかしい. yamlが間違っている気がする　なるはやで直したい🖊️🍍🍎🖊️
        let url = URL(string: self.imgUrl ?? "")
        let image = UIImage.init(url: url)
        let isMine = self.isMine ?? "false"
        return .init(
            userName: self.userName ?? "匿名",
            receivedAt: self.sendAt?.parseFromBariPortFormat() ?? Date.now,
            userType: (isMine == "true") ? .me : .other,
            userIcon: image,
            body: self.text ?? "")
    }
}

final class MockDirectMessageInteractor: DirectMessageUsecase{
    func fetchHello() async throws -> DirectMessageEntity.Hello? {
        nil
    }
    
    func fetchMessages(chatRoomID: String, loginUserId: String) async throws -> [DirectMessageEntity.Message] {
        []
    }
    
    func postMessage(chatRoomID: String, userID: String, message: String) async throws {
        true
    }
}
