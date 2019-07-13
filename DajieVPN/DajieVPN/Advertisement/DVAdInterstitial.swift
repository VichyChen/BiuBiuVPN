//
//  DVAdInterstitial.swift
//  DajieVPN
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 DajieVPN. All rights reserved.
//

import UIKit

class DVAdInterstitial: NSObject, GADInterstitialDelegate {
    
    var interstitial: GADInterstitial?
    
    override init() {
        super.init()
        
        createAndLoadInterstitial()
    }
    
    private func createAndLoadInterstitial() {
        self.interstitial = GADInterstitial(adUnitID: kAdMobAdInterstitialID)
        self.interstitial?.delegate = self
        self.interstitial?.load(GADRequest())
    }
    
    public func presentFromViewController(viewController: UIViewController) {
        if self.interstitial!.isReady {
            self.interstitial?.present(fromRootViewController: viewController)
        }
    }
    
    // MARK:- GADInterstitialDelegate
    
    public func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        createAndLoadInterstitial()
    }
}
