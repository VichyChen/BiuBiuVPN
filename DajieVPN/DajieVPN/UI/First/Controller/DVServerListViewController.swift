//
//  DVServerListViewController.swift
//  DajieVPN
//
//  Created by mac on 2017/4/16.
//  Copyright © 2017年 DajieVPN. All rights reserved.
//

import UIKit
import SwiftyJSON

class DVServerListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var serverlistResult: JSON?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "服务器列表"
        self.tableView.tableFooterView = UIView()
        self.tableView!.register(UINib(nibName:"DVServerListCell", bundle:nil), forCellReuseIdentifier:"DVServerListCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (serverlistResult?["result"].array?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DVServerListCell = tableView.dequeueReusableCell(withIdentifier: "DVServerListCell")
            as! DVServerListCell
        cell.titleLabel?.text = serverlistResult?["result"][0]["region"].string
        cell.flagImageView.sd_setImage(with: URL.init(string: (serverlistResult?["result"][0]["imgurl"].string)!))
        print((serverlistResult?["result"][0]["imgurl"].string)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        _ = navigationController?.popViewController(animated: true)
    }
}
