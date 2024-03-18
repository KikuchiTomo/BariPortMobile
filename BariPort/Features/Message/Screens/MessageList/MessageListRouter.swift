import UIKit
import Foundation

protocol MessageListWireframe: AnyObject{
    func presetDirectMessageView(directMessageID: UUID)
}

final class MessageListRouter: MessageListWireframe{
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules() -> UIViewController{
        let view = MessageListViewController()
        let router = MessageListRouter(viewController: view)
        let interactor = MessageListInteractor()

        let presenter = MessageListPresenter(
          view: view,
          router: router,
          interactor: interactor                        
        )

        view.presenter = presenter
        return view      
    }
    
    @MainActor static func assembleModules(tag: Int) -> TabHostEntity.TabItem{
        .init(
            viewController: MessageListRouter.assembleModules(),
            tabItem: .directMessageTabBarItem(tag: tag)
        )
    }
    
    @MainActor func presetDirectMessageView(directMessageID: UUID) {
        self.viewController.navigationController?.pushViewController(DirectMessageRouter.assembleModules(), animated: true)
    }
}
