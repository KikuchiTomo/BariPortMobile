import UIKit
import Foundation

protocol ProjectListPresentation: AnyObject {

}

@MainActor final class ProjectListPresenter: ProjectListPresentation{
    private weak var view: ProjectListView?
    private let router: ProjectListWireframe
    private let interactor: ProjectListUsecase

    init(view: ProjectListView,
         router: ProjectListWireframe,
         interactor: ProjectListUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

final class MockProjectListPresenter: ProjectListPresentation{

}
