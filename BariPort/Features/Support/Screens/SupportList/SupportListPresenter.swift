import UIKit
import Foundation

protocol SupportListPresentation: AnyObject {
    var dataSource: SupportListDataSource { get }
    
    func supportDetailButtonDidTap()
}

final class SupportListPresenter: SupportListPresentation{
    private weak var view: SupportListView?
    private let router: SupportListWireframe
    private let interactor: SupportListUsecase
    
    public var dataSource: SupportListDataSource

    init(view: SupportListView,
         router: SupportListWireframe,
         interactor: SupportListUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
        self.dataSource = .init()        
    }
    
    func supportDetailButtonDidTap(){
        Task{ @MainActor in            
            self.router.openURL(url: URL(string: "https://it-saiyou-kitaq.com/")!)
        }
    }
}

final class MockSupportListPresenter: SupportListPresentation{
    var dataSource: SupportListDataSource = .init()
    
    func supportDetailButtonDidTap(){
        
    }
}
