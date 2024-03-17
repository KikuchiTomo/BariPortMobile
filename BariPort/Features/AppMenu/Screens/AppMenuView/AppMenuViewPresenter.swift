import UIKit
import Foundation

protocol AppMenuViewPresentation: AnyObject {

}

@MainActor final class AppMenuViewPresenter: AppMenuViewPresentation{
    private weak var view: AppMenuViewView?
    private let router: AppMenuViewWireframe
    private let interactor: AppMenuViewUsecase

    init(view: AppMenuViewView,
         router: AppMenuViewWireframe,
         interactor: AppMenuViewUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

final class MockAppMenuViewPresenter: AppMenuViewPresentation{

}
