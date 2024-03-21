import Foundation
import BariPortAPI

protocol DirectMessageUsecase: AnyObject {
    
    // example
    // このAPIがどこからとってきたものなのかは気にしない. そのため返す方はEntityで定義されたものに変換する
    func getHello() async throws -> DirectMessageEntity.Hello?
}

final class DirectMessageInteractor: DirectMessageUsecase{
    init(){}
        
    func getHello() async throws -> DirectMessageEntity.Hello? {
        let result = try await BariPortAPIClient.shared.getHello()
        return result.convert()
    }
}

extension BariPortAPI.Hello{
    func convert() -> DirectMessageEntity.Hello?{
        guard let message = self.message else { return nil }
        return .init(message: message)
    }
}

final class MockDirectMessageInteractor: DirectMessageUsecase{
    func getHello() async throws -> DirectMessageEntity.Hello? {
        nil
    }
    

}
