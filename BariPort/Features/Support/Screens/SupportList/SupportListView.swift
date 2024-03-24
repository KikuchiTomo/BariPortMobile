import UIKit
import Foundation
import UIComponents

protocol SupportListView: AnyObject{
    func viewWillReloadData()
    func viewWillShowLoadingView()
    func viewWillHideLoadingView()
}

class SupportListViewController: UIViewController, UITableViewDelegate{
    var presenter: SupportListPresentation!
    
    private lazy var headerView = generateHeaderView()
    private lazy var tableView = generateTableView() 
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizationString.supportTabBarItemLabel.localized
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
        self.setNavRightButton(.init(image: .Common.logout, style: .plain ,target: self, action: #selector(viewDidTapLogout)))       
        self.view.backgroundColor = .white
        self.registerActionButton(button: self.headerView.supportLinkButton)
        self.configViews()
    }
    
    @objc func viewDidTapLogout(){
        self.presenter.viewDidTapLogout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLoading()
        self.presenter.viewDidAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tableView.tableHeaderView = self.headerView
        self.layoutViews()
        
        var frame = self.headerView.frame
        frame.size.height = 150
        self.tableView.tableHeaderView!.frame = frame
    }
}

extension SupportListViewController{
    func registerActionButton(button: UIButton){
        button.addTarget(self, action: #selector(viewDidTapSupportDetailButton(_:)), for: .touchUpInside)
    }
    
    @objc func viewDidTapSupportDetailButton(_ sender: UIButton){
        // https://it-saiyou-kitaq.com/
        self.presenter.supportDetailButtonDidTap()
    }
    
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
    func viewWillReloadData(){
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            // ここで headerView の値を更新します。
            self.headerView.setValue(value: self.presenter.dataSource.totalReputationValue)
            self.tableView.reloadData()
        }
    }
    
    func viewWillShowLoadingView(){
        self.showLoading()
    }
    
    func viewWillHideLoadingView(){
        self.hideLoading()
    }
}
