import Foundation
import BariPortAPI

protocol DirectMessageUsecase: AnyObject {
    
    // example
    // このAPIがどこからとってきたものなのかは気にしない. そのため返す方はEntityで定義されたものに変換する
    func fetchHello() async throws -> DirectMessageEntity.Hello?
    func fetchMessages(chatRoomID: String) async throws -> [DirectMessageEntity.Message]
    func postMessage(chatRoomID: String, userID: String, message: String) async throws -> Bool
}

final class DirectMessageInteractor: DirectMessageUsecase{
    init(){}
        
    func fetchHello() async throws -> DirectMessageEntity.Hello? {
        let result = try await BariPortAPIClient.getHello()
        return result.convert()
    }
    
    func fetchMessages(chatRoomID: String) async throws -> [DirectMessageEntity.Message] {
        return try await BariPortAPIClient.getMessages(chatRoomID: chatRoomID).map{
            $0.convert()
        }
    }
    
    func postMessage(chatRoomID: String, userID: String, message: String) async throws -> Bool{
        return try await BariPortAPIClient.postMessage(userID: userID, chatRoomID: chatRoomID, message: message).convert()
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
        .init(
            userName: "",
            receivedAt: Date.now,
            userType: .me,
            userIcon: nil,
            body: self.text ?? "")
    }
}

final class MockDirectMessageInteractor: DirectMessageUsecase{
    func fetchHello() async throws -> DirectMessageEntity.Hello? {
        nil
    }
    
    func fetchMessages(chatRoomID: String) async throws -> [DirectMessageEntity.Message] {
        []
    }
    
    func postMessage(chatRoomID: String, userID: String, message: String) async throws -> Bool{
        true
    }
}
