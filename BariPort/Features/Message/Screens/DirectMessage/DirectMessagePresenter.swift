import UIKit
import Foundation

protocol DirectMessagePresentation: AnyObject {

}

@MainActor final class DirectMessagePresenter: DirectMessagePresentation{
    private weak var view: DirectMessageView?
    private let router: DirectMessageWireframe
    private let interactor: DirectMessageUsecase

    init(view: DirectMessageView,
         router: DirectMessageWireframe,
         interactor: DirectMessageUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

final class MockDirectMessagePresenter: DirectMessagePresentation{

}
