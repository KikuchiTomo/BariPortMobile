import UIKit
import Foundation

protocol LandingPresentation: AnyObject {
    func viewDidTapSignUpButton()
    func viewDidTapSignInButton()
}

final class LandingPresenter: LandingPresentation{
    func viewDidTapSignUpButton() {
        Task{ @MainActor in
            self.router.presentSignUpView()
        }
    }
    
    func viewDidTapSignInButton() {
        Task{ @MainActor in
            self.router.presnetSignInView()
        }
    }
    
    internal weak var view: LandingView?
    internal let router: LandingWireframe
    internal let interactor: LandingUsecase
    
    init(view: LandingView,
         router: LandingWireframe,
         interactor: LandingUsecase) {
        
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

final class MockLandingPresenter: LandingPresentation{
    func viewDidTapSignUpButton() {
        
    }
    
    func viewDidTapSignInButton() {
        
    }
}
