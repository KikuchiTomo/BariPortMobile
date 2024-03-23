import UIKit
import Foundation

protocol DirectMessagePresentation: AnyObject {
    var dataSource: DirectMessageDataSource { get }
}

final class DirectMessagePresenter: DirectMessagePresentation{
    private weak var view: DirectMessageView?
    private let router: DirectMessageWireframe
    private let interactor: DirectMessageUsecase
    
    internal var dataSource: DirectMessageDataSource       
    
    init(view: DirectMessageView,
         router: DirectMessageWireframe,
         interactor: DirectMessageUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor    
        
        self.dataSource = .init()              
    }
}

final class MockDirectMessagePresenter: DirectMessagePresentation{
    internal var dataSource: DirectMessageDataSource = .init()
}
