//
//  AppDelegate.swift
//  DajieVPN
//
//  Created by mac on 2017/3/26.
//  Copyright © 2017年 DajieVPN. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var adInterstitial: DVAdInterstitial?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        initUMengAnalytics()
        initUMengSocial()
        initAdMob()
        
        return true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return UMSocialSnsService.handleOpen(url)
    }

    func initUMengAnalytics() {
        let config = UMAnalyticsConfig()
        config.appKey = kUmengAppKey
        MobClick.start(withConfigure: config)
    }
    
    func initUMengSocial() {
        UMSocialData.setAppKey(kUmengAppKey)
        UMSocialWechatHandler.setWXAppId(kWechatAppID, appSecret: kWechatAppSecret, url: nil)
        UMSocialQQHandler.setQQWithAppId(kQQAppID, appKey: kQQAppKey, url: "http://www.umeng.com/social")
    }
    
    func initAdMob() {
        self.adInterstitial = DVAdInterstitial()
    }
}

