import UIKit
import Foundation

protocol LandingWireframe: RootRouter, AnyObject{

}

final class LandingRouter: LandingWireframe{
    internal unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules() -> UIViewController{
        let view = LandingViewController()
        let router = LandingRouter(viewController: view)
        let interactor = LandingInteractor()

        let presenter = LandingPresenter(
          view: view,
          router: router,
          interactor: interactor                        
        )

        view.presenter = presenter
        return view      
    }
}
