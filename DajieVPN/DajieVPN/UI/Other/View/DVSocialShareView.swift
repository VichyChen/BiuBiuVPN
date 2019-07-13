//
//  DVSocialShareView.swift
//  DajieVPN
//
//  Created by mac on 2017/4/4.
//  Copyright © 2017年 DajieVPN. All rights reserved.
//

import UIKit

class DVSocialShareView: UIView {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    var url: String?
    var title: String?
    var content: String?
    var image: String?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.contentView.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: self.contentView.frame.size.height)
        self.backgroundView.alpha = 0
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.close()
    }
    
    @IBAction func backgroundTapAction(_ sender: UITapGestureRecognizer) {
        self.close()
    }
    
    @IBAction func wechatSessionTapAction(_ sender: UITapGestureRecognizer) {
        GCSocial .share(toWechatSession: self.url, title: self.title, content: self.content, success: { 
            
        }) { 
            
        }
    }
    
    @IBAction func wechatTimelineTapAction(_ sender: UITapGestureRecognizer) {
        GCSocial.share(toWechatTimeline: self.url, title: self.title, success: { 
            
        }) { 
            
        }
    }
    
    @IBAction func qqTapAction(_ sender: UITapGestureRecognizer) {
        GCSocial.share(toQQ: self.url, title: self.title, content: self.content, success: { 
            
        }) { 
            
        }
    }

    public func show() {
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        (UIApplication.shared.delegate as! AppDelegate).window?.addSubview(self)
        UIView.animate(withDuration: 0.35) {
            self.backgroundView.alpha = 0.3
            self.contentView.frame = CGRect(x: 0, y: kScreenHeight - self.contentView.frame.size.height, width: kScreenWidth, height: self.contentView.frame.size.height)
        }
    }
    
    public func close() {
        UIView.animate(withDuration: 0.35, animations: {
            self.backgroundView.alpha = 0
            self.contentView.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: self.contentView.frame.size.height)
        }) { (completion) in
            if self.superview != nil {
                self.removeFromSuperview()
            }
        }
    }
    
    static func show(url: String, title: String, content: String, image: String) {
        let socialShareView = Bundle.main.loadNibNamed("DVSocialShareView", owner: self, options: nil)?[0] as! DVSocialShareView
        socialShareView.url = url
        socialShareView.title = title
        socialShareView.content = content
        socialShareView.image = image
        socialShareView.show()
    }
}
