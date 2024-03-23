import Foundation
import BariPortAPI

protocol DirectMessageUsecase: AnyObject {
    
    // example
    // このAPIがどこからとってきたものなのかは気にしない. そのため返す方はEntityで定義されたものに変換する
    func fetchHello() async throws -> DirectMessageEntity.Hello?
    func fetchMessages(chatRoomID: String) async throws -> [DirectMessageEntity.Message]
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
}
