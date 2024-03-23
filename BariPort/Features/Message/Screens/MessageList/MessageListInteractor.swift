import Foundation
import BariPortAPI

protocol MessageListUsecase: AnyObject {
    func fetchMessages(projectID: String) async throws -> [MessageListEntity.Cell]
}

final class MessageListInteractor: MessageListUsecase{
    init(){}
    
    func fetchMessages(projectID: String) async throws -> [MessageListEntity.Cell]{
        return try await BariPortAPIClient.getChatRooms(projectID: projectID).map{ $0.convert() }
    }
}

extension ChatRooms{
    func convert() -> MessageListEntity.Cell{
        // TODO: ここもWebAPIから帰ってくる値がよくわからないので聞く
        .init(
            id: self._id ?? UUID().uuidString,
            summary: self.type ?? "",
            productName: self.projectId ?? "",
            companyName: self.name ?? "",
            image: nil
        )
    }
}

final class MockMessageListInteractor: MessageListUsecase{
    func fetchMessages(projectID: String) async throws -> [MessageListEntity.Cell] {
        []
    }    
}
