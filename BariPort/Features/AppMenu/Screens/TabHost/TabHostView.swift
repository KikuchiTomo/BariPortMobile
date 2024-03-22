import UIKit
import Foundation

// Presenterからはここに定義したAPIしか叩いてはいけない
protocol TabHostView: AnyObject{

}

protocol TabHostDataframe{
    var viewController: UIViewController { get }
    var tabItem: UITabBarItem { get }
}

class TabHostViewController<TabItem: TabHostDataframe>: UITabBarController, UITabBarControllerDelegate{
    var presenter: TabHostPresentation!
    var tabItems: [TabItem]
    
    init(tabItems: [TabItem]){
        self.tabItems = tabItems
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setUpScreens()
        configureNavigationBarAppearance()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {   
        self.presenter.viewDidChangedTab(tag: item.tag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension TabHostViewController{
    func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        // 背景色を設定
        appearance.backgroundColor = UIColor.systemBlue
        
        // タイトルテキストの属性を設定
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 20)]
        
        // 大きなタイトルテキストの属性を設定（iOS 11 以降で利用可能）
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 34)]
        
        // ボタンの外観をカスタマイズ
        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.buttonAppearance = buttonAppearance
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6 // グレーの背景色を設定

        // iOS 15以降では、新しいアピアランスAPIを使用してスタイルを設定します。
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func setUpScreens(){
        let viewControllers: [UINavigationController] = self.tabItems.map{ tabItem in
            let viewController = tabItem.viewController
            let navigationController = viewController.generatedRootNavigationController()
            navigationController.tabBarItem = tabItem.tabItem
            return navigationController
        }
        
        self.viewControllers = viewControllers
    }
}

// 外部向けのAPI実装用
extension TabHostViewController: TabHostView{
    
}
