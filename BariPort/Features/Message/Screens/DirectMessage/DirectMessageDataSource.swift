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
    
    internal var dataSource: AsyncArray<DirectMessageEntity.Message> = .init([
        .init(userName: "Hoge", receivedAt: Date.now, userType: .other, body: "初めて利用させていただきました！！北九州市の魅力を知ることができる素敵なプロダクトだと思いました！これからも応援しています！！"),
        .init(userName: "PiyoPiyo", receivedAt: Date.now, userType: .me, body: "北九州市にとっても恩恵を与えることができる素敵なアプリだと思います！"),
        .init(userName: "Hoge2", receivedAt: Date.now, userType: .other, body: "ローディングが長くユーザー体験の改善ができれば良いと思いました！mm")
    ])
    
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
