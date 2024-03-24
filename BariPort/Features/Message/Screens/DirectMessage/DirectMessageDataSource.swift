//
//  DirectMessagePresenterDataSource.swift
//  BariPort
//
//  Created by Tomo Kikuchi on 2024/03/19.
//

import Foundation
import UIKit
import UIComponents

class DirectMessageDataSource: NSObject, UITableViewDataSource{
    internal let cellIdentifier: String = UUID().uuidString
    
    internal var dataSource: AsyncArray<DirectMessageEntity.Message> = .init([])
    
    func updateItems(_ items: [DirectMessageEntity.Message]){
        self.dataSource.removeAll()
        self.dataSource.append(items)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.dataSource[indexPath.row]
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        ?? DirectMessageTableCell<DirectMessageEntity.Message>.init(reuseIdentifier: cellIdentifier)
        
        if let listCell = reuseCell as? DirectMessageTableCell<DirectMessageEntity.Message>{
            // TODO: メッセージが取り出すことができなかった時のUIを用意して, nilが渡されたら再送できるようにする
            listCell.updateContent(
                content: message ??
                .init(userName: "", receivedAt: Date(), userType: .me, body: ""))
        }
               
        return reuseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
