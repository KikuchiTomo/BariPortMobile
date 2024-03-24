import UIKit
import Foundation

protocol DirectMessageWireframe: RootRouter, AnyObject{

}

final class DirectMessageRouter: DirectMessageWireframe{
   
    
    internal unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules(chatRoomID: String) -> UIViewController{
        let view = DirectMessageViewController()
        let router = DirectMessageRouter(viewController: view)
        let interactor = DirectMessageInteractor()

        let presenter = DirectMessagePresenter(
          view: view,
          router: router,
          interactor: interactor,
          chatRoomID: chatRoomID
        )

        view.presenter = presenter
        return view      
    }
    
    static func assembleModules() -> UIViewController {
        fatalError()
    }
}
