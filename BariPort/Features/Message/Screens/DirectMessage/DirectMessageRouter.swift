import UIKit
import Foundation

protocol DirectMessageWireframe: AnyObject{

}

final class DirectMessageRouter: DirectMessageWireframe{
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules() -> UIViewController{
        let view = DirectMessageViewController()
        let router = DirectMessageRouter(viewController: view)
        let interactor = DirectMessageInteractor()

        let presenter = DirectMessagePresenter(
          view: view,
          router: router,
          interactor: interactor                        
        )

        view.presenter = presenter
        return view      
    }
}
