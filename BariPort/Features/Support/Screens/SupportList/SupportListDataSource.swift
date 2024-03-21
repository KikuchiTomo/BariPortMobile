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
    
    internal var dataSource: AsyncArray<SupportListEntity.Cell> = .init([
        .init(
            companyName: "HogeHoge Inc.",
            comment: "弊社は北九州市の魅力を全国に発信したい想いから創業し、北九州市の魅力を誰でも気軽に発信することができる to Cサービスアプロのベータ版をリリースしております。しかし、資金面で困難になることがありましたが、北九州市のご支援のおかげで乗り越えることができました！弊社のように、やりたいことがあっても資金面で実現困難な企業さんは多くいらっしゃると思います。ぜひ、北九州市の支援を受けて、事業を伸ばしていける企業が増えていってほしいです！",
            createdAt: Date.now,
            reputationValue: 2.5),
        .init(
            companyName: "Daretoku Inc.",
            comment: "弊社は北九州市の魅力を全国に発信したい想いから創業し、北九州市の魅力を誰でも気軽に発信することができる to Cサービスアプロのベータ版をリリースしております。しかし、資金面で困難になることがありましたが、北九州市のご支援のおかげで乗り越えることができました！弊社のように、やりたいことがあっても資金面で実現困難な企業さんは多くいらっしゃると思います。ぜひ、北九州市の支援を受けて、事業を伸ばしていける企業が増えていってほしいです！",
            createdAt: Date.now,
            reputationValue: 5),
        .init(
            companyName: "HogeHoge Inc.",
            comment: "弊社は北九州市の魅力を全国に発信したい想いから創業し、北九州市の魅力を誰でも気軽に発信することができる to Cサービスアプロのベータ版をリリースしております。しかし、資金面で困難になることがありましたが、北九州市のご支援のおかげで乗り越えることができました！弊社のように、やりたいことがあっても資金面で実現困難な企業さんは多くいらっしゃると思います。ぜひ、北九州市の支援を受けて、事業を伸ばしていける企業が増えていってほしいです！",
            createdAt: Date.now,
            reputationValue: 1),
        .init(
            companyName: "Daretoku Inc.",
            comment: "弊社は北九州市の魅力を全国に発信したい想いから創業し、北九州市の魅力を誰でも気軽に発信することができる to Cサービスアプロのベータ版をリリースしております。しかし、資金面で困難になることがありましたが、北九州市のご支援のおかげで乗り越えることができました！弊社のように、やりたいことがあっても資金面で実現困難な企業さんは多くいらっしゃると思います。ぜひ、北九州市の支援を受けて、事業を伸ばしていける企業が増えていってほしいです！",
            createdAt: Date.now,
            reputationValue: 5),
        .init(
            companyName: "HogeHoge Inc.",
            comment: "弊社は北九州市の魅力を全国に発信したい想いから創業し、北九州市の魅力を誰でも気軽に発信することができる to Cサービスアプロのベータ版をリリースしております。しかし、資金面で困難になることがありましたが、北九州市のご支援のおかげで乗り越えることができました！弊社のように、やりたいことがあっても資金面で実現困難な企業さんは多くいらっしゃると思います。ぜひ、北九州市の支援を受けて、事業を伸ばしていける企業が増えていってほしいです！",
            createdAt: Date.now,
            reputationValue: 1),
        .init(
            companyName: "Daretoku Inc.",
            comment: "弊社は北九州市の魅力を全国に発信したい想いから創業し、北九州市の魅力を誰でも気軽に発信することができる to Cサービスアプロのベータ版をリリースしております。しかし、資金面で困難になることがありましたが、北九州市のご支援のおかげで乗り越えることができました！弊社のように、やりたいことがあっても資金面で実現困難な企業さんは多くいらっしゃると思います。ぜひ、北九州市の支援を受けて、事業を伸ばしていける企業が増えていってほしいです！",
            createdAt: Date.now,
            reputationValue: 5),
        .init(
            companyName: "HogeHoge Inc.",
            comment: "弊社は北九州市の魅力を全国に発信したい想いから創業し、北九州市の魅力を誰でも気軽に発信することができる to Cサービスアプロのベータ版をリリースしております。しかし、資金面で困難になることがありましたが、北九州市のご支援のおかげで乗り越えることができました！弊社のように、やりたいことがあっても資金面で実現困難な企業さんは多くいらっしゃると思います。ぜひ、北九州市の支援を受けて、事業を伸ばしていける企業が増えていってほしいです！",
            createdAt: Date.now,
            reputationValue: 1)
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
