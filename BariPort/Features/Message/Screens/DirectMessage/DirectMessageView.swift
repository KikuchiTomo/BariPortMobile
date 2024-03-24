import UIKit
import Foundation
import UIComponents

protocol DirectMessageView: AnyObject{
    func viewWillUpdateTableView()
}

class DirectMessageViewController: UIViewController, UITableViewDelegate{
    var presenter: DirectMessagePresentation!
    
    private lazy var tableView: UITableView = generateTableView()
    private lazy var gradationView: GradationView = generateGradationView()
    private lazy var downloadButtonView: AppDownloadButton = generateButton()
    private lazy var inputFormView: InputFormView = generateInputFormButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.configViews()
        self.setupInputFormView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tableView.tableHeaderView = self.downloadButtonView
        self.layoutViews()
        
        var frame = self.downloadButtonView.frame
        frame.size.height = 60
        self.tableView.tableHeaderView!.frame = frame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    func generateTableView() -> UITableView{
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func generateGradationView() -> GradationView{
        let view = GradationView(
            startPoint: .init(x: 0.5, y: 0.0),
            endPoint: .init(x: 0.5, y: 1.0),
            colors: [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor])
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
        self.view.addSubview(self.gradationView)
        
        self.tableView.dataSource = self.presenter.dataSource
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        
        self.inputFormView.sendButton.addTarget(self, action: #selector(viewDidTapSendButton(_:)), for: .touchUpInside)
    }
    
    func generateInputFormButton() -> InputFormView{
        let view = InputFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func setupInputFormView() {
        guard let tabBarHeight = self.tabBarController?.tabBar.frame.size.height else { return }
        
        view.addSubview(inputFormView)
               
        NSLayoutConstraint.activate([
            inputFormView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarHeight),
            inputFormView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputFormView.trailingAnchor.constraint(equalTo: view.trailingAnchor),            
        ])
    }
    
    @objc func viewDidTapSendButton(_ sender: UIButton){
        guard let text = self.inputFormView.textField.text else { return }
        
        self.presenter.viewDidTapSendButton(message: text)
        
        self.inputFormView.textField.text = ""
        self.inputFormView.textField.resignFirstResponder()
    }
    
    // safeAreadInsetsはlayout後に大きさが確定
    func layoutViews(){
        let topConstant = self.view.safeAreaInsets.top
        
        NSLayoutConstraint.activate([
            downloadButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButtonView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            downloadButtonView.heightAnchor.constraint(equalToConstant: 60),
            
            // tableView.topAnchor.constraint(equalTo: downloadButtonView.bottomAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant + 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            gradationView.topAnchor.constraint(equalTo: tableView.topAnchor),
            gradationView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            gradationView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            gradationView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: imp
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, animations: {
            if scrollView.contentOffset.y <= 0.0{
                self.gradationView.alpha = 0.0
            }else{
                self.gradationView.alpha = 1.0
            }})
    }
    
  
}

extension DirectMessageViewController: DirectMessageView{
    func viewWillUpdateTableView(){
        self.tableView.reloadData()
    }
}
