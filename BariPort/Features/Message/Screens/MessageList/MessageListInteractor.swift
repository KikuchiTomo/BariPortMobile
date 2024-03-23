import Foundation
import UIKit
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
        let url = URL(string: self.imgUrl ?? "")
        let image = UIImage(url: url)
               
        return .init(
            id: self._id ?? UUID().uuidString ,
            summary: self.latestMessage ?? "",
            productName: self.projectName ?? "",
            companyName: self.companyName ?? "",
            image: image
        )
    }
}

final class MockMessageListInteractor: MessageListUsecase{
    func fetchMessages(projectID: String) async throws -> [MessageListEntity.Cell] {
        []
    }    
}
