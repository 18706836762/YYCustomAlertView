//
//  HomeViewController.swift
//  YYCustomAlert
//
//  Created by 王园园 on 15/10/23.
//  Copyright © 2015年 王园园. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let M_Width = CGRectGetWidth(self.view.frame)
        //self.navigationTitle.text = "技术"
        self.title = "YYCustomAlert"
        self.view.backgroundColor = UIColor.yellowColor()
        
        let noneBtn =  UIButton(type: UIButtonType.Custom)
        noneBtn.frame = CGRectMake(M_Width/2-50, 100, 100, 40)
        noneBtn.setTitle("noneBtn", forState: UIControlState.Normal)
        noneBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        noneBtn.addTarget(self, action: Selector("nonebtnPress"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(noneBtn)
        
        let oneBtn =  UIButton(type: UIButtonType.Custom)
        oneBtn.frame = CGRectMake(M_Width/2-50, 180, 100, 40)
        oneBtn.setTitle("oneBtn", forState: UIControlState.Normal)
        oneBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        oneBtn.addTarget(self, action: Selector("onebtnPress"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(oneBtn)
        
        let twoBtn =  UIButton(type: UIButtonType.Custom)
        twoBtn.frame = CGRectMake(M_Width/2-50, 260, 100, 40)
        twoBtn.setTitle("twoBtn", forState: UIControlState.Normal)
        twoBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        twoBtn.addTarget(self, action: Selector("twobtnPress"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(twoBtn)
        
    }
    func nonebtnPress()->Void
    {
        let alert = YYCustomAlert(frame: UIScreen.mainScreen().bounds)
        alert.initBody("温馨提示", message: "您的网络开小差了", DismissDelay: 2)
        //ture有弹动动画  false没有动画
        alert.showTypeNoneButton (true){ () -> () in
            NSLog("消失")
        }
    }
    
    func onebtnPress()->Void
    {
        let alert = YYCustomAlert(frame: UIScreen.mainScreen().bounds)
        alert.initOneBtn("温馨提示", message: "您的网络开小差了", ButtonTitle: "知道了")
        alert.showTypeOneButton (true){ () -> () in
            NSLog("知道了")
        }
    }
    
    func twobtnPress()->Void
    {
        let alert = YYCustomAlert(frame: UIScreen.mainScreen().bounds)
        alert.initTwoBtn("温馨提示", message: "您的网络开小差了", cancelButtonTitle: "知道了", otherButtonTitle: "设置")
        alert.showTypeTwoButton(true,leftClick: { () -> () in
            NSLog("知道了")
            }) { () -> () in
                NSLog("设置")
        }
    }
    
    
}
