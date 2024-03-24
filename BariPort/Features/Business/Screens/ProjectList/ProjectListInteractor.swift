import Foundation
import BariPortAPI

protocol ProjectListUsecase: AnyObject {
    func fetchProjectList() async throws -> [ProjectListEntity.Cell]
    func postJoinChatRoom(userID: String, chatRoomID: String) async throws -> Bool
}

final class ProjectListInteractor: ProjectListUsecase{
    init(){}
    // TODO: API周りの実装
    func fetchProjectList() async throws -> [ProjectListEntity.Cell] {
        return try await BariPortAPIClient.getProjects().map{
            $0.convert()
        }
    }
    
    func postJoinChatRoom(userID: String, chatRoomID: String) async throws -> Bool{
        return try await BariPortAPIClient.postChatRoomParticipants(chatRoomId: chatRoomID, userId: userID).convert()
    }
}

extension Projects{
    func convert() -> ProjectListEntity.Cell {
        // TODO: ここでは全てOptionalにして, UIで受信できなかったことを表示すべき
        .init(
            url: URL(string: self.testUrl ?? "https://www.weblio.jp/content/%E6%BA%96%E5%82%99%E4%B8%AD")!, 
            id: self.chatRoomId ?? "",
            projectName: self.projectName ?? "",
            companyName: self.companyName ?? "",
            comment: self._description ?? "")
    }
}

final class MockProjectListInteractor: ProjectListUsecase{
    func postJoinChatRoom(userID: String, chatRoomID: String) async throws -> Bool {
        false
    }
    
    func fetchProjectList() async throws -> [ProjectListEntity.Cell]{
        []
    }
    
    func postJoinChatRoom(userID: String) async throws -> Bool{
        false
    }
}
