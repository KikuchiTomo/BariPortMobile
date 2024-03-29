//
//  ProjectListDataSource.swift
//  BariPort
//
//  Created by 渡辺大智 on 2024/03/23.
//
import Foundation
import UIKit
import UIComponents

class ProjectListDataSource: NSObject, UITableViewDataSource{
    internal let cellIdentifier: String = UUID().uuidString
    internal var dataSource: AsyncArray<ProjectListEntity.Cell> = .init([])
    
    internal var initialized: Bool = false
    
    internal var presenter: ProjectListPresentation? = nil
    
    func updateData(items: [ProjectListEntity.Cell]) {
        self.dataSource.removeAll()
        self.dataSource.append(items)
        
        initialized = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.dataSource[indexPath.row]
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        ?? ProjectListTableCell<ProjectListEntity.Cell>.init(reuseIdentifier: cellIdentifier)
        
        if let listCell = reuseCell as? ProjectListTableCell<ProjectListEntity.Cell>{
            // TODO: メッセージが取り出すことができなかった時のUIを用意して, nilが渡されたら再送できるようにする
            listCell.updateContent(
                content: message ??
                    .init(url: URL(string: "https://www.weblio.jp/content/%E6%BA%96%E5%82%99%E4%B8%AD")!, id: "", projectName: "", companyName: "", comment: ""))
            listCell.viewDidTapDirectMessage = { id in
                self.presenter?.viewDidTapDM(id)
                self.presenter?.viewDidTapJoin(chatRoomID: id)
            }
            listCell.viewDidTapTester = { url in
                self.presenter?.viewDidTapTester(url)
            }
        }
               
        return reuseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
}
