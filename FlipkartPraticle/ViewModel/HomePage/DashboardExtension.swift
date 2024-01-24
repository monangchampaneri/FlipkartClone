//
//  DashboardExtension.swift
//  FlipkartPraticle
//
//  Created by Monang Champaneri on 24/01/24.
//

import Foundation
import UIKit

extension DashboardVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as! BannerCell
            cell.configCell()
            return cell
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.configCell()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExclusiveProductCell", for: indexPath) as! ExclusiveProductCell
            cell.configCell()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
            cell.configCell()
            return cell
        default:
            return UITableViewCell()
        }
    
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            return 200
        }
        else if indexPath.row == 0{
            return 80
        }
        else if indexPath.row == 2{
            return 150
        }
        else if indexPath.row == 3{
            return 1000
        }
        else{
            return 0
        }
    }
    
    
}
