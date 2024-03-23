import UIKit
import Foundation

protocol LandingPresentation: AnyObject {

}

@MainActor final class LandingPresenter: LandingPresentation{
    private weak var view: LandingView?
    private let router: LandingWireframe
    private let interactor: LandingUsecase

    init(view: LandingView,
         router: LandingWireframe,
         interactor: LandingUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

final class MockLandingPresenter: LandingPresentation{

}
