import UIKit
import Foundation

protocol ProjectListPresentation: AnyObject {
    var dataSource: ProjectListDataSource { get }
    
    func viewDidTapDM()
    func viewDidAppear()
    func viewWillRefresh()
}

final class ProjectListPresenter: ProjectListPresentation{
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
        self.dataSource.presenter = self
    }
    
    func viewDidTapDM(){
        Switcher.shared.tabSwitch(to: 1)
    }
    
    func viewDidAppear(){
        fetchProjectList()
    }
    
    func viewWillRefresh() {
        fetchProjectList()
    }
    
    fileprivate func fetchProjectList() {
        Task {
            do {
                let result = try await self.interactor.fetchProjectList()
                Task{ @MainActor in
                    self.dataSource.updateData(items: result)
                    self.view?.viewWillReloadData()
                    self.view?.viewWillHideLoadingView()
                }
            } catch let error {
                Task{ @MainActor in
                    self.router.presentError(error: error)
                }
            }
        }
    }
}

final class MockProjectListPresenter: ProjectListPresentation{
    func viewDidTapDM() {
        
    }
    
    var dataSource: ProjectListDataSource
    
    init() {
        dataSource = .init()
        dataSource.presenter = self
    }
    
    func viewDidAppear() {
        
    }
    
    func viewWillRefresh() {
        
    }
}
