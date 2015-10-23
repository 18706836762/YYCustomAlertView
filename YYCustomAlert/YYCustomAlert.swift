//
//  YYCustomAlert.swift
//  studySwift1
//
//  Created by 王园园 on 15/10/21.
//  Copyright © 2015年 王园园. All rights reserved.
//

import UIKit
import QuartzCore

let KTitltOringy:CGFloat = 15.0
let KTitltHeight:CGFloat = 25.0
let KContentOringy:CGFloat = 30.0
let KBetweenLableOffset:CGFloat = 20.0
let KAlertWidth:CGFloat = 245.0
let KAlertHeight:CGFloat = 160.0

typealias leftBlock = () ->()
typealias rightBlock = ()->()
typealias DelaydismissBlock = ()->()


class YYCustomAlert: UIView {
    
    var leftblock : leftBlock?
    var rightblock : rightBlock?
    var dismissblock : DelaydismissBlock?
    var alertTitleLabel : UILabel?
    var alertContentLabel : UILabel?
    var leftBtn : UIButton?
    var rightBtn : UIButton?
    var backImageView:UIView?
    
    var delayTime:Int64 = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
    }
    
    //没有按钮
    func initBody(title:NSString,message:NSString,DismissDelay:Int64)
    {
        self.delayTime = DismissDelay
        self.initTwoBtn(title, message: message, cancelButtonTitle: "", otherButtonTitle: "")
    }
    //一个按钮
    func initOneBtn(title:NSString,message:NSString,ButtonTitle:NSString)
    {
        self.initTwoBtn(title, message: message, cancelButtonTitle: "", otherButtonTitle: ButtonTitle)
    }
    //两个按钮
    func initTwoBtn(title:NSString,message:NSString,cancelButtonTitle:NSString,otherButtonTitle:NSString) {
        
        //super.init(frame: CGRectZero)
        backImageView = UIImageView(frame: CGRectMake(0, 0, KAlertWidth, KAlertHeight))
        backImageView?.center = self.center
        backImageView?.backgroundColor = UIColor.whiteColor()
        backImageView?.layer.cornerRadius = 5.0
        backImageView?.userInteractionEnabled = true
        self.addSubview(backImageView!)

     
        alertTitleLabel = UILabel(frame: CGRectMake(0, KTitltOringy, KAlertWidth, KTitltHeight))
        alertTitleLabel!.font = UIFont.boldSystemFontOfSize(20.0)
        alertTitleLabel!.textColor = UIColor(red:56.0/255.0,green:64.0/255.0,blue:71.0/255.0,alpha:1)
        backImageView?.addSubview(alertTitleLabel!)
        
        
        let contentLabelWidth = KAlertWidth - 16
        alertContentLabel = UILabel(frame:CGRectMake((KAlertWidth - contentLabelWidth) * 0.5, CGRectGetMaxY(alertTitleLabel!.frame), contentLabelWidth, 60))
        alertContentLabel!.numberOfLines = 0
        alertContentLabel!.textAlignment = NSTextAlignment.Center
        alertTitleLabel!.textAlignment = NSTextAlignment.Center
        alertContentLabel!.textColor = UIColor(red:127.0/255.0,green:127.0/255.0,blue:127.0/255.0,alpha:1)
        alertContentLabel!.font = UIFont.systemFontOfSize(15.0)
        backImageView?.addSubview(alertContentLabel!)
        
        alertTitleLabel!.text = title as String
        alertContentLabel!.text = message as String
        
        let KSingleButtonWidth:CGFloat = 160.0
        let kCoupleButtonWidth:CGFloat = 107.0
        let kButtonHeight:CGFloat = 40.0
        let kButtonBottomOffset:CGFloat = 10.0
        
        //没有按钮
        if cancelButtonTitle.length==0 && otherButtonTitle.length==0{
            
            alertTitleLabel?.frame.origin.y = KTitltOringy+20
            alertContentLabel?.frame.size.height = 100
            if(self.delayTime==0){
                self.delayTime = 2
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(Int64)(self.delayTime*Int64(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                self.dismissblock!()
                self.removeFromSuperview()
            })
            return
        }else if cancelButtonTitle.length>0 && otherButtonTitle.length>0 {
        //laing个按钮
            let leftBtnFrame = CGRectMake((KAlertWidth - 2 * kCoupleButtonWidth - kButtonBottomOffset) * 0.5, KAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            let rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame) + kButtonBottomOffset, KAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            leftBtn = UIButton(frame:leftBtnFrame);
            leftBtn?.setBackgroundImage(UIImage(named: "button_white_normal"), forState: UIControlState.Normal)
            leftBtn?.setBackgroundImage(UIImage(named: "button_white_clicked"), forState: UIControlState.Selected)
            leftBtn!.setTitle(cancelButtonTitle as String, forState: UIControlState.Normal)
            leftBtn!.titleLabel!.font = UIFont.boldSystemFontOfSize(14)
            leftBtn!.setTitleColor(UIColor.lightGrayColor(),forState:UIControlState.Normal)
            leftBtn!.addTarget(self, action: "leftBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
            leftBtn!.layer.masksToBounds = true
             backImageView?.addSubview(leftBtn!)
            leftBtn!.layer.masksToBounds = true
            leftBtn!.layer.cornerRadius = 3.0
            
            rightBtn = UIButton(frame:rightBtnFrame)
        }else{
             //一个按钮
            rightBtn = UIButton(frame:CGRectMake((KAlertWidth-KSingleButtonWidth)/2, KAlertHeight - kButtonBottomOffset - kButtonHeight, KSingleButtonWidth, kButtonHeight))
        }
     
        rightBtn!.setBackgroundImage( UIImage(named: "button_orange_normal") ,forState:UIControlState.Normal)
        rightBtn!.setBackgroundImage( UIImage(named: "button_orange_click") ,forState:UIControlState.Selected)
        rightBtn!.setTitle(otherButtonTitle as String, forState: UIControlState.Normal)
        rightBtn!.titleLabel!.font = UIFont.boldSystemFontOfSize(14)
        rightBtn!.setTitleColor(UIColor.whiteColor(),forState:UIControlState.Normal)
        rightBtn!.addTarget(self, action: "rightBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        rightBtn!.layer.masksToBounds = true
        rightBtn!.layer.cornerRadius = 3.0
        backImageView?.addSubview(rightBtn!)
        
        
    }
    
    func leftBtnClicked(){
        
        self.leftblock!()
        self.dismiss()
    }
    
    func rightBtnClicked(){
        self.rightblock!()
        self.dismiss()
    }
    func showTypeNoneButton(animation:Bool,dismiss:DelaydismissBlock!)->Void
    {
        self.occur(animation)
        self.dismissblock = dismiss
    }
    func showTypeOneButton(animation:Bool,rightClick:rightBlock!)->Void
    {
        self.occur(animation)
        self.rightblock = rightClick
    }
    func showTypeTwoButton(animation:Bool,leftClick:leftBlock! ,rightClick:rightBlock!)->Void{
        self.occur(animation)
        self.leftblock = leftClick
        self.rightblock = rightClick
    }
    
    func occur(animation:Bool) -> Void{
        
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
        if animation {
        
            UIView.animateWithDuration(0.1, delay: 0, options:
                UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                    self.alpha = 1.0
                    self.backImageView?.layer.setAffineTransform(CGAffineTransformMakeScale(0.9, 0.9))
                }) { (Bool) -> Void in
                    UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                        backImageView?.layer.setAffineTransform(CGAffineTransformMakeScale(1.1, 1.1))
                        }) { (Bool) -> Void in
                            UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                                backImageView?.layer.setAffineTransform(CGAffineTransformMakeScale(0.9, 0.9))
                                }) { (Bool) -> Void in
                                    backImageView?.layer.setAffineTransform(CGAffineTransformMakeScale(1.0, 1.0))
                            }
                    }
            }
        }
    }
    
    func dismiss() -> Void{
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.alpha = 0
            }) { (Bool) -> Void in
               self.removeFromSuperview()
        }
       
    }
    
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
}
