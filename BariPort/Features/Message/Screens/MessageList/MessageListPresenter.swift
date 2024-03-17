import UIKit
import Foundation

protocol MessageListPresentation: AnyObject {

}

@MainActor final class MessageListPresenter: MessageListPresentation{
    private weak var view: MessageListView?
    private let router: MessageListWireframe
    private let interactor: MessageListUsecase

    init(view: MessageListView,
         router: MessageListWireframe,
         interactor: MessageListUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

final class MockMessageListPresenter: MessageListPresentation{

}
