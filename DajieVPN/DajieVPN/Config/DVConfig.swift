//
//  DVConfig.swift
//  DajieVPN
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 DajieVPN. All rights reserved.
//


public let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height


public let kAppleID: String = "1219221866"

//微信appid
public let kWechatAppID: String = "wxae373f8f2971bc3a"
//微信appsecret
public let kWechatAppSecret: String = "732265ab4fbaf5160016d6d301f4c956"
//QQappid
public let kQQAppID: String = "1106081530"
//QQappkey
public let kQQAppKey: String = "MMBk6GikUznD1HLu"

#if Debug
    
    //友盟Key
    public let kUmengAppKey: String = "58d8b8f6a40fa3069e00143b"
    //首页BannerView
    public let kAdMobFirstBannerViewID: String = "ca-app-pub-3940256099942544/2934735716"
    //全屏广告
    public let kAdMobAdInterstitialID: String = "ca-app-pub-3940256099942544/4411468910"

#else
    
    //友盟Key
    public let kUmengAppKey: String = "58d8b91045297d22f10018b9"
    //首页BannerView
    public let kAdMobFirstBannerViewID: String = "ca-app-pub-8708280892532766/7959992533"
    //全屏广告
    public let kAdMobAdInterstitialID: String = "ca-app-pub-8708280892532766/9436725732"

#endif

