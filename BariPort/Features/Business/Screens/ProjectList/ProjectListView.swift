import UIKit
import Foundation
import UIComponents

protocol ProjectListView: AnyObject{

}

class ProjectListViewController: UIViewController{
    var presenter: ProjectListPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()        
        self.title = LocalizationString.homeTabBarItemLabel.localized
        // TODO: 画像にしたほうがいいかも
        let serviceNameLabel = UILabel()
        serviceNameLabel.text = "BariPort"
        serviceNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        serviceNameLabel.textColor = .systemCyan
        // コンテナビューを作成し、左側に余白を追加します。
        let containerView = UIView()
        // ここでのX座標を調整することで、余白のサイズを変更できます。
        // 例えば、X座標を10に設定することで、左側に10ポイントのスペースが追加されます。
        serviceNameLabel.frame = CGRect(x: 20, y: 0, width: serviceNameLabel.intrinsicContentSize.width, height: serviceNameLabel.intrinsicContentSize.height)
        
        // コンテナビューのサイズを、内包するラベルのサイズに基づいて設定します。
        // ここでは、ラベルの幅に余白分を追加しています。
        containerView.frame = CGRect(x: 0, y: 0, width: serviceNameLabel.frame.width + 10, height: serviceNameLabel.frame.height)
        containerView.addSubview(serviceNameLabel)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
        self.view.backgroundColor = .white
    }
}

extension ProjectListViewController: ProjectListView{

}
