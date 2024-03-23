import UIKit
import Foundation

protocol SignInPresentation: AnyObject {

}

@MainActor final class SignInPresenter: SignInPresentation{
    private weak var view: SignInView?
    private let router: SignInWireframe
    private let interactor: SignInUsecase

    init(view: SignInView,
         router: SignInWireframe,
         interactor: SignInUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

final class MockSignInPresenter: SignInPresentation{

}
