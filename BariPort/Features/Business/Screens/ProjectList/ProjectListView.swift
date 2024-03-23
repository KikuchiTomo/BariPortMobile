import UIKit
import Foundation
import UIComponents

protocol ProjectListView: AnyObject{
    func viewWillReloadData()
    func viewWillShowLoadingView()
    func viewWillHideLoadingView()
}

class ProjectListViewController: UIViewController, UITableViewDelegate {
    var presenter: ProjectListPresentation!
    
    private lazy var tableView = generateTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: 画像にしたほうがいいかも
        let serviceNameLabel = UILabel()
        serviceNameLabel.text = "BariPort"
        serviceNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        serviceNameLabel.textColor = .systemCyan
        let containerView = UIView()
        serviceNameLabel.frame = CGRect(x: 20, y: 0, width: serviceNameLabel.intrinsicContentSize.width, height: serviceNameLabel.intrinsicContentSize.height)
        
        containerView.frame = CGRect(x: 0, y: 0, width: serviceNameLabel.frame.width + 10, height: serviceNameLabel.frame.height)
        containerView.addSubview(serviceNameLabel)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
        self.view.backgroundColor = .white
        
        self.configViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLoading()
        self.presenter.viewDidAppear()
    }
}

extension ProjectListViewController: ProjectListView{
    func generateTableView() -> UITableView{
        let view = UITableView()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutViews()
        tableView.layoutIfNeeded()
    }
    
    func layoutViews(){
        let topConstant = self.view.safeAreaInsets.top
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant + 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
        setUpHeader()
    }
    
    func setUpHeader() {
        let headerView = UIView()
        // headerViewの高さを設定
        let headerHeight: CGFloat = 30
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: headerHeight)
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "北九州市の事業一覧"
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24) 
        headerView.addSubview(titleLabel)
        
        // Auto Layout制約をtitleLabelに適用
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
        ])
        
        tableView.tableHeaderView = headerView
    }
}

extension ProjectListViewController: SupportListView{
    func viewWillReloadData() {
        self.tableView.reloadData()
    }
    
    func viewWillShowLoadingView() {
        self.showLoading()
    }
    
    func viewWillHideLoadingView() {
        self.hideLoading()
    }
}
