//
//  SupportListDataSource.swift
//  BariPort
//
//  Created by Tomo Kikuchi on 2024/03/21.
//

import Foundation
import UIKit
import UIComponents

class SupportListDataSource: NSObject, UITableViewDataSource{
    internal let cellIdentifier: String = UUID().uuidString
    internal var dataSource: AsyncArray<SupportListEntity.Cell> = .init([])
    
    internal var initialized: Bool = false
    
    var totalReputationValue: Float{
        get{
            if dataSource.count <= 0 {
                return 0.0
            }
            
            var value: Float = 0.0
            dataSource.forEach{
                value += $0.reputationValue
            }
            value /= Float(dataSource.count)
            return value
        }
    }
    
    func updateData(items: [SupportListEntity.Cell]){
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
        ?? SupportListTableCell<SupportListEntity.Cell>.init(reuseIdentifier: cellIdentifier)
        
        if let listCell = reuseCell as?SupportListTableCell<SupportListEntity.Cell>{
            // TODO: メッセージが取り出すことができなかった時のUIを用意して, nilが渡されたら再送できるようにする
            listCell.updateContent(
                content: message ??
                    .init(companyName: "", comment: "", createdAt: Date.now, reputationValue: 0.0))
        }
               
        return reuseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
}
