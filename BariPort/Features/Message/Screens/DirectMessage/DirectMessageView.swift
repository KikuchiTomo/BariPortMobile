import UIKit
import Foundation
import UIComponents

protocol DirectMessageView: AnyObject{

}

class DirectMessageViewController: UIViewController, UITableViewDelegate{
    var presenter: DirectMessagePresentation!
    
    private lazy var tableView: UITableView = generateTableView()
    private lazy var downloadButtonView: AppDownloadButton = generateButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.configViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutViews()
    }
    
    func generateTableView() -> UITableView{
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func generateButton() -> AppDownloadButton{
        // TODO: AppDownloadButtonの方で後から情報をセットできるようにする．
        let view = AppDownloadButton(productName: "Hogehoge", companyName: "株式会社 HogeHoge")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func configViews(){
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.downloadButtonView)
        
        self.tableView.dataSource = self.presenter.dataSource
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
    }
    
    // safeAreadInsetsはlayout後に大きさが確定
    func layoutViews(){
        let topCostant = self.view.safeAreaInsets.top
        
        NSLayoutConstraint.activate([
            downloadButtonView.topAnchor.constraint(equalTo: view.topAnchor, constant: topCostant + 16),
            downloadButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButtonView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            downloadButtonView.heightAnchor.constraint(equalToConstant: 60),
            
            tableView.topAnchor.constraint(equalTo: downloadButtonView.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: imp
    }
}

extension DirectMessageViewController: DirectMessageView{
    
}
