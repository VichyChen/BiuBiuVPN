//
//  DVNavigationController.swift
//  DajieVPN
//
//  Created by mac on 2017/4/3.
//  Copyright © 2017年 DajieVPN. All rights reserved.
//

import UIKit

class DVNavigationController: UINavigationController,UINavigationControllerDelegate {
    
    override class func initialize() {
//        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
//        // 设置导航条前景色
//        [bar setTintColor:[UIColor whiteColor]];
//        
//        // 获取导航条按钮的标识
//        UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
//        // 修改返回按钮标题的位置
//        [item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -1000) forBarMetrics:UIBarMetricsDefault];
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weak var wk_self = self

        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.delegate = wk_self
            self.interactivePopGestureRecognizer?.delegate = wk_self as! UIGestureRecognizerDelegate?
        }

        self.navigationBar.tintColor = kDVWhiteColor
        self.navigationBar.barTintColor = kDVDeepBlueColor
        self.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : kDVWhiteColor, NSFontAttributeName : UIFont.systemFont(ofSize: 18)];
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            let button = UIButton(type: .custom)
            button.setTitleColor(UIColor.white, for: .normal)
            button.setTitleColor(UIColor.red, for: .highlighted)
            button.setImage(UIImage(named:"icon_backArrow"), for: .normal)
            button.sizeToFit()
            
            button.frame = CGRect(x: 0, y: 0, width: 54, height: 44)
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0)
            
            button.addTarget(self, action: #selector(back), for: .touchUpInside)
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        }
        
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // 当一个viewController完全显示出来后，必须得恢复滑动返回功能，不然界面显示出来后就没有滑动返回功能了。
        // ps:为什么不在push做？push可能会较慢，前面保证了意外发生，这里是viewController已经push完成，界面显示时，这样再恢复是安全的，至少比在push过程中恢复安全
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.isEnabled = (self.childViewControllers.count > 1) ? true : false
        }
    }
    
    func back() {
        self.popViewController(animated: true)
    }
}
