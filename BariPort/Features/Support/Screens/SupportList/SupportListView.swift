import UIKit
import Foundation
import UIComponents

protocol SupportListView: AnyObject{

}

class SupportListViewController: UIViewController, UITableViewDelegate{
    var presenter: SupportListPresentation!
    
    private lazy var headerView = generateHeaderView()
    private lazy var tableView = generateTableView()
        
    override func viewDidLoad() {
        super.viewDidLoad() 
        self.title = LocalizationString.supportTabBarItemLabel.localized
        self.view.backgroundColor = .white
        
        self.configViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tableView.tableHeaderView = self.headerView
        self.layoutViews()
        
        var frame = self.headerView.frame
        frame.size.height = 150
        self.tableView.tableHeaderView!.frame = frame
        
        self.headerView.value = 4.4
    }
}

extension SupportListViewController{
    func generateTableView() -> UITableView{
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func generateHeaderView() -> SupportSummaryView{
        let view = SupportSummaryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func setupTableView(){
        self.view.addSubview(tableView)
        tableView.delegate = self
    }
    
    func configViews(){
        self.view.addSubview(self.tableView)
        
        self.tableView.dataSource = self.presenter.dataSource
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
    }
    
    func layoutViews(){
        let topConstant = self.view.safeAreaInsets.top
        
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant + 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
    }
}

extension SupportListViewController: SupportListView{

}
