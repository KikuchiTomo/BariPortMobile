import Foundation
import BariPortAPI

protocol ProjectListUsecase: AnyObject {
    func fetchProjectList() async throws -> [ProjectListEntity.Cell]
}

final class ProjectListInteractor: ProjectListUsecase{
    init(){}
    // TODO: API周りの実装
    func fetchProjectList() async throws -> [ProjectListEntity.Cell] {
        return try await BariPortAPIClient.getProjects().map{
            $0.convert()
        }
    }
}

extension Projects{
    func convert() -> ProjectListEntity.Cell {
        // TODO: ここでは全てOptionalにして, UIで受信できなかったことを表示すべき
        .init(
            projectName: self.projectName ? "",
            companyName: self.companyName ?? "",
            comment: self._description ?? "")
    }
}

final class MockProjectListInteractor: ProjectListUsecase{
    func fetchProjectList() async throws -> [ProjectListEntity.Cell]{
        []
    }
}
