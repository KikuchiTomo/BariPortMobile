import UIKit
import Foundation

protocol MessageListWireframe: RootRouter, AnyObject{
    func presetDirectMessageView(chatRoomID: String)
}

final class MessageListRouter: MessageListWireframe{
    internal unowned let viewController: UIViewController

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
    
    @MainActor func presetDirectMessageView(chatRoomID: String) {
        self.viewController.navigationController?.pushViewController(DirectMessageRouter.assembleModules(chatRoomID: chatRoomID), animated: true)
    }
}
