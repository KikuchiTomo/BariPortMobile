import UIKit
import Foundation
import UIComponents

protocol MessageListView: AnyObject{
    func appendedDirectMessageList(_ content: [MessageListEntity.Cell])
    func updateDirectMessageList(_ content: [MessageListEntity.Cell])
    func endRefreshing()
}

class MessageListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private lazy var directMessageTableView: UITableView = generateTableView()
    private let refreshControl = UIRefreshControl()
    // DataSourceをPresenterに持っていたほうが綺麗なので要リファクタリング
    private var dataSource: AsyncArray<MessageListEntity.Cell> = .init([])
    private let cellIdentifier: String = UUID().uuidString
    
    var presenter: MessageListPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()    
        self.title = LocalizationString.directMessageTabBarItemLabel.localized
        
        directMessageTableView.delegate = self
        directMessageTableView.dataSource = self
        
        layoutViews()
        addRefreshControl()
    }
    
    func generateTableView() -> UITableView{
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func layoutViews(){
        self.view.addSubview(directMessageTableView)
        
        NSLayoutConstraint.activate([
            // self.directMessageTableView
            directMessageTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            directMessageTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            directMessageTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            directMessageTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    func addRefreshControl(){
        self.directMessageTableView.refreshControl = self.refreshControl
        guard let refreshControl = self.directMessageTableView.refreshControl else { return }
        refreshControl.addTarget(self, action: #selector(refreshControlDidAppear), for: .valueChanged)
    }
    
    @objc func refreshControlDidAppear(){
        Task{
            presenter.refreshControlViewDidAppear()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Task{
            guard let message = dataSource[indexPath.row] else { return }
            presenter.directMessageListCellDidTap(id: message.id)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = dataSource[indexPath.row]
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        ?? DirectMessageListTableCell<MessageListEntity.Cell>.init(reuseIdentifier: cellIdentifier)
        
        // TODO: DirectMessageListTableCellではnilを許容してその旨を表示できるようにすべき
        if let listCell = reuseCell as? DirectMessageListTableCell<MessageListEntity.Cell>{
            listCell.updateContent(content: message ?? .init(id: UUID().uuidString, summary: "", productName: "", companyName: ""))
        }
               
        return reuseCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension MessageListViewController: MessageListView{
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func appendedDirectMessageList(_ content: [MessageListEntity.Cell]) {
        self.dataSource.append(content)
        self.directMessageTableView.reloadData()
    }
    
    func updateDirectMessageList(_ content: [MessageListEntity.Cell]) {
        self.dataSource.removeAll()
        self.dataSource.append(content)
        self.directMessageTableView.reloadData()
    }
}
