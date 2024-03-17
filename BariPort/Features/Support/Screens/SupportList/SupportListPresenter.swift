import UIKit
import Foundation

protocol SupportListPresentation: AnyObject {

}

@MainActor final class SupportListPresenter: SupportListPresentation{
    private weak var view: SupportListView?
    private let router: SupportListWireframe
    private let interactor: SupportListUsecase

    init(view: SupportListView,
         router: SupportListWireframe,
         interactor: SupportListUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

final class MockSupportListPresenter: SupportListPresentation{

}
