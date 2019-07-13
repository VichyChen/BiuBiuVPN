//
//  DVLeftMenuViewController.swift
//  DajieVPN
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 DajieVPN. All rights reserved.
//

import UIKit

class DVLeftMenuViewController: UITableViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.versionLabel.text = "v \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)"
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return kScreenWidth / 2 - 20
        }
        else if indexPath.row == 5 {
            return kScreenHeight - 50.0 * 4 - (kScreenWidth / 2 - 20)
        }
        else {
            return 50.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
            
        case 1://商店评分
            UIApplication.shared.openURL(URL.init(string: "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(kAppleID)&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8")!)
            break
            
        case 2://分享
            DVSocialShareView.show(url: "www.baidu.com", title: "BiuBiuVPN", content: "BiuBiuVPN content", image: "")
            break
            
        case 3://帮助
            
            break
            
        case 4://关于我们
            
            break
            
        default:
            break
        }
    }
}
