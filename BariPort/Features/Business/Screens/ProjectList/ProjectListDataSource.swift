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
    
    internal var dataSource: AsyncArray<ProjectListEntity.Cell> = .init([
        .init(
            projectName: "HogeProject",
            companyName: "HogeHoge Inc.",
            comment: "ご覧いただきありがとうございます！弊社では、北九州を詳しくご存じでない方にも、北九州の観光地やグルメを楽しんでいただくためのプロダクト「HOGEHOGE」（ベータ版）をリリースしております！ぜひ下記「アプリを使ってみる」よりアプリをダウンロードしていただき、お使いいただいた感想を「口コミ」にて発信していただけますと励みになります！！"
        ),
        .init(
            projectName: "Project HogePiyo",
            companyName: "PiyoPiyo Inc.",
            comment: "ご覧いただきありがとうございます！弊社では、北九州を詳しくご存じでない方にも、北九州の観光地やグルメを楽しんでいただくためのプロダクト「HogePiyo」（ベータ版）をリリースしております！ぜひ下記「アプリを使ってみる」よりアプリをダウンロードしていただき、お使いいただいた感想を「口コミ」にて発信していただけますと励みになります！！"
        ),
    ])
    
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
                    .init(projectName: "", companyName: "", comment: ""))
        }
               
        return reuseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
}
