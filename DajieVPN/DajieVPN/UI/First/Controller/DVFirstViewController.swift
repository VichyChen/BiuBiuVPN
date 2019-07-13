//
//  DVFirstViewController.swift
//  DajieVPN
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 DajieVPN. All rights reserved.
//

import UIKit
import NetworkExtension
import Alamofire
import SwiftyJSON

class DVFirstViewController: UIViewController {
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var serverNameButton: UIButton!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var server: String?
    var account: String?
    var password: String?
    var psk: String?
    var flagURL: String?
    var region: String?

    var serverlistResult: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vpnStateChanged(status: VPNManager.shared.status)
        VPNManager.shared.statusEvent.attach(self, DVFirstViewController.vpnStateChanged)
        
        bannerView.adUnitID = kAdMobFirstBannerViewID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        if let json = UserDefaults.standard.value(forKey: kDVDefaultServer) {
            self.serverlistResult = JSON(json)
            self.setupDefault()
        }
        
        getServerlist();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "serverlist") {
            let controller: DVServerListViewController = segue.destination as! DVServerListViewController;
            controller.serverlistResult = self.serverlistResult
        }
    }

    func vpnStateChanged(status: NEVPNStatus) {
        switch status {
        case .disconnected, .invalid, .reasserting:
            self.connectButton.setTitle("连接", for: .normal)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
        case .connected:
            self.connectButton.setTitle("断开", for: .normal)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
        case .connecting:
            self.connectButton.setTitle("正在连接...", for: .normal)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        case .disconnecting:
            self.connectButton.setTitle("正在断开...", for: .normal)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
        }
    }
    
    @IBAction func connectAction(_ sender: UIButton) {
        if (VPNManager.shared.isDisconnected) {
            let config = Configuration(
                server: self.server ?? (serverlistResult?["result"][0]["ip"].string)!,
                account: self.account ?? (serverlistResult?["result"][0]["username"].string)!,
                password: self.password ?? (serverlistResult?["result"][0]["passwd"].string)!,
                onDemand: false,
                psk: self.psk ?? (serverlistResult?["result"][0]["psk"].string)!)
            VPNManager.shared.connectIKEv2(config: config) { error in
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            }
            config.saveToDefaults()
            
            let delay = DispatchTime.now() + .seconds(2)
            DispatchQueue.main.asyncAfter(deadline: delay, execute: { 
                (UIApplication.shared.delegate as! AppDelegate).adInterstitial?.presentFromViewController(viewController: self)
            })
        } else {
            VPNManager.shared.disconnect()
        }
    }

    func getServerlist () {
        Alamofire.request("https://www.dajievpn.xyz/serverlist", method: .get, parameters: nil).responseJSON {
            response in
            if let json = response.result.value {
                print("JSON: \(json)")

                self.serverlistResult = JSON(json)
                
                UserDefaults.standard.set(json, forKey: kDVDefaultServer)
                UserDefaults.standard.synchronize()

                if !(self.serverlistResult!["result"].array!.isEmpty) {
                    self.setupDefault()
                }
            }
        }
    }
    
    func setupDefault() {
        self.flagImageView.sd_setImage(with: URL.init(string:self.flagURL ?? ((serverlistResult?["result"][0]["imgurl"].string)!)))
        self.serverNameButton.setTitle((self.region ?? (self.serverlistResult?["result"][0]["region"].string)?.appending("   >")), for: UIControlState.normal)
    }
}
