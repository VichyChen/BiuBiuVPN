//
//  DVRootViewController.swift
//  DajieVPN
//
//  Created by mac on 2017/4/7.
//  Copyright © 2017年 DajieVPN. All rights reserved.
//

import UIKit

class DVRootViewController: RESideMenu, RESideMenuDelegate {

    override func awakeFromNib() {        

        self.menuPreferredStatusBarStyle = UIStatusBarStyle.lightContent
        self.contentViewController = self.storyboard?.instantiateViewController(withIdentifier: "contentViewController");
        self.leftMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "leftMenuViewController");
        
        self.delegate = self;
    }

}
