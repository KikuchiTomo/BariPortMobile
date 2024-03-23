import UIKit
import Foundation

protocol ProjectListPresentation: AnyObject {
    var dataSource: ProjectListDataSource { get }
}

@MainActor final class ProjectListPresenter: ProjectListPresentation{
    private weak var view: ProjectListView?
    private let router: ProjectListWireframe
    private let interactor: ProjectListUsecase
    
    public var dataSource: ProjectListDataSource

    init(view: ProjectListView,
         router: ProjectListWireframe,
         interactor: ProjectListUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
        self.dataSource = .init()
    }
}

final class MockProjectListPresenter: ProjectListPresentation{
    var dataSource: ProjectListDataSource = .init()
}
