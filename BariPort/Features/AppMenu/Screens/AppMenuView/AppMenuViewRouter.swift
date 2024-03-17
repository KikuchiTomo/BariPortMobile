import UIKit
import Foundation

protocol AppMenuViewWireframe: AnyObject{

}

final class AppMenuViewRouter: AppMenuViewWireframe{
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules() -> UIViewController{
        let view = AppMenuViewViewController()
        let router = AppMenuViewRouter(viewController: view)
        let interactor = AppMenuViewInteractor()

        let presenter = AppMenuViewPresenter(
          view: view,
          router: router,
          interactor: interactor                        
        )

        view.presenter = presenter
        return view      
    }
}
