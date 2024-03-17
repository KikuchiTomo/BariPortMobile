import UIKit
import Foundation

protocol TabHostPresentation: AnyObject {
    func viewWillAppear()
    func viewDidChangedTab(tag: Int) 
}

@MainActor final class TabHostPresenter: TabHostPresentation{
    nonisolated func viewWillAppear() {
        
    }
    
    nonisolated func viewDidChangedTab(tag: Int) {
        // Log Event
        
    }
    
    private weak var view: TabHostView?
    private let router: TabHostWireframe
    private let interactor: TabHostUsecase

    init(view: TabHostView,
         router: TabHostWireframe,
         interactor: TabHostUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

final class MockTabHostPresenter: TabHostPresentation{
    func viewWillAppear() {
        
    }
    
    func viewDidChangedTab(tag: Int) {
        
    }
}
