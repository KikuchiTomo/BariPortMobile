import UIKit
import Foundation

protocol ProjectListPresentation: AnyObject {
    var dataSource: ProjectListDataSource { get }
    
    func viewDidTapDM(_ id: String)
    func viewDidAppear()
    func viewWillRefresh()
    func viewDidTapTester(_ url: URL)
    func viewDidTapLogout()
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
    
    func viewDidTapDM(_ id: String){
        Switcher.shared.tabSwitch(to: 1)
    }
    
    func viewDidAppear(){
        fetchProjectList()
    }
    
    func viewWillRefresh() {
        fetchProjectList()
    }
    
    func viewDidTapTester(_ url: URL){
        Task{ @MainActor in
            router.openURL(url: url)
        }
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
    
    func viewDidTapLogout(){
        Task{ @MainActor in
            // TODO: ここ汚すぎるのでリファクタする
            // TODO: ローカライズする
            self.router.presentAlert(type:
                .alert(
                    "確認",
                    "ログアウトしますか？",
                    [
                        .ok({ _ in
                            Task{
                                do{
                                    _ = try await AuthenticationManager.shared.signOut()
                                    Task{ @MainActor in
                                        // TODO: ログアウト後の画面
                                    }
                                }catch(let error){
                                    Task{ @MainActor in
                                        self.router.presentError(error: error)
                                    }
                                }
                            }
                        }),
                        .cancel({ _ in
                            
                        })
                    ])
            )
        }
    }
}

final class MockProjectListPresenter: ProjectListPresentation{
    func viewDidTapDM(_ id: String) {
        
    }
    
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
    
    func viewDidTapTester(_ url: URL) {
        
    }
    
    func viewDidTapLogout(){
        
    }
}
