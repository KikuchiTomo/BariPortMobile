import Foundation
import UIKit

struct TabHostEntity{
    struct TabItem: TabHostDataframe{
          var viewController: UIViewController
          var tabItem: UITabBarItem
         
          init(viewController: UIViewController, tabItem: UITabBarItem) {
              self.viewController = viewController
              self.tabItem = tabItem
          }
      }
}
