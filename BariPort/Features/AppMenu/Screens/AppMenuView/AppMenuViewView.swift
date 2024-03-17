import UIKit
import Foundation

protocol AppMenuViewView: AnyObject{

}

class AppMenuViewViewController: UITabBarController {
    var presenter: AppMenuViewPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarAppearance()
        configuration()
    }
    
    func configuration() {
        // UIViewControllerインスタンスを作成
        let firstViewController = setUpScreen("BariPort")
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        // 同様に、他のタブのビューコントローラーを設定
        let secondViewController = setUpScreen("Second")
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        let thirdViewController = setUpScreen("Third")
        thirdViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        // タブバーコントローラーにナビゲーションコントローラーをセット
        self.viewControllers = [firstViewController, secondViewController, thirdViewController]
    }
}

extension AppMenuViewViewController: AppMenuViewView {
    func setUpScreen(_ title: String) -> UIViewController {
        let viewController = UIViewController()
        viewController.title = title
        let navViewController = UINavigationController(rootViewController: viewController)
        return navViewController
    }
    
    func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray3 // グレーの背景色を設定

        // iOS 15以降では、新しいアピアランスAPIを使用してスタイルを設定します。
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
