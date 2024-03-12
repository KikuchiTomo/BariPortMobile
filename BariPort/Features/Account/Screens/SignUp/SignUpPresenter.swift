import UIKit
import Foundation

protocol SignUpPresentation: AnyObject {

}

@MainActor final class SignUpPresenter: SignUpPresentation{
    private weak var view: SignUpView?
    private let router: SignUpWireframe
    private let interactor: SignUpUsecase

    init(view: SignUpView,
         router: SignUpWireframe,
         interactor: SignUpUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

final class MockSignUpPresenter: SignUpPresentation{

}
