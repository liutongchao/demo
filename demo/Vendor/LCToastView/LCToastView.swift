//
//  LCToastView.swift
//  TestToast
//
//  Created by 上海牧客网络科技有限公司 on 2017/3/22.
//  Copyright © 2017年 Mifit. All rights reserved.
//
import UIKit

fileprivate let ToastViewHeight:CGFloat = 35
fileprivate var ToastViewWidth:CGFloat = 320
fileprivate let ToastFontSize = 15
fileprivate let ToastCornerRadius = 5
fileprivate let ToastAnimateTime = 0.3
fileprivate let ToastShowTime = 1.5

fileprivate let ToastBackColor = UIColor.black

class LCToastView: UIView {
    
    var complete: ((Bool)->Void)?
    
    class func showGlobalToast(info:String){
        if info == "" {
            return
        }
        let app = UIApplication.shared.delegate
        
        guard let window = app?.window  else {
            return
        }
        guard window != nil  else {
            return
        }
        createToast(info: info, view: window!).show()
    }
    
    //MARK: - init
    class func createToast(info: String, view:UIView) -> LCToastView {
        
        let viewWidth = view.frame.size.width
        let avaliableWidth = viewWidth - 40
        
        var infoHeight = ToastViewHeight
        var infoWidth = getInfoWidth(info: info)
        if infoWidth > avaliableWidth {
            infoWidth = avaliableWidth
            infoHeight = getInfoHeight(info: info, width: avaliableWidth)
        }
        let lableFrame = CGRect.init(x: 0, y: 0, width: infoWidth, height: infoHeight)
        let backFrame = CGRect.init(x: 0, y: 0, width: infoWidth+20, height: infoHeight+20)
        let baseFrame = CGRect.init(x: 0, y: 0, width: infoWidth+40, height: infoHeight+40)
        
        //创建底
        let toastView = createToastView(frame: baseFrame)
        toastView.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2)
        toastView.alpha = 0
        view.addSubview(toastView)
        
        //创建背景
        let infoBack = createInfoBack(frame: backFrame)
        infoBack.center = CGPoint.init(x: (infoWidth+40)/2, y: (infoHeight+40)/2)
        toastView.addSubview(infoBack)
        
        //创建lable
        let infoLabel = createInfoLabel(frame: lableFrame)
        infoLabel.text = info
        infoLabel.center = CGPoint.init(x: (infoWidth+40)/2, y: (infoHeight+40)/2)
        toastView.addSubview(infoLabel)
        
        return toastView
    }
    
    //MARK: - show hidden
    func show(_ showTime:TimeInterval = TimeInterval(ToastShowTime)) {
        UIView.animate(withDuration: ToastAnimateTime) {
            self.alpha = 1
        }
        self.superview?.bringSubviewToFront(self)
//        self.perform(#selector(hidden), with: nil, afterDelay: TimeInterval(showTime))
        self.perform(#selector(hidden), with: nil, afterDelay: TimeInterval(showTime), inModes: [RunLoop.Mode.common])
    }
    
    func show(complete:@escaping ((Bool)->Void)) {
        self.complete = complete
        show()
    }
    
    @objc fileprivate func hidden() {
        if self.complete != nil {
            self.complete!(true)
        }
        UIView.animate(withDuration: ToastAnimateTime) {
            self.alpha = 0
        }
        self.perform(#selector(remove), with: nil, afterDelay: ToastAnimateTime, inModes: [RunLoop.Mode.default])
    }
    
    @objc fileprivate func remove() {
        self.removeFromSuperview()
    }
    
    //MARK: - fileprivate meta======
    fileprivate class func createToastView(frame: CGRect) -> LCToastView{
        let toastView = LCToastView.init(frame: frame)
        
        return toastView
    }
    fileprivate class func createInfoBack(frame:CGRect) -> UIView{
        let infoView = UIView.init(frame: frame)
        infoView.backgroundColor = ToastBackColor
        infoView.alpha = 0.75
        infoView.layer.masksToBounds = true
        infoView.layer.cornerRadius = CGFloat(ToastCornerRadius)
        
        return infoView
    }
    
    fileprivate class func createInfoLabel(frame:CGRect) -> UILabel{
        let infoLable = UILabel.init(frame: frame)
        infoLable.backgroundColor = UIColor.clear
        infoLable.font = UIFont.systemFont(ofSize: CGFloat(ToastFontSize))
        infoLable.textColor = UIColor.white
        infoLable.textAlignment = .center
        infoLable.numberOfLines = Int.max
        
        return infoLable
    }

    
    fileprivate class func getInfoWidth(info:String) -> CGFloat {
        let size = CGSize.init(width: CGFloat(Int.max), height: ToastViewHeight)
        let rect = info.boundingRect(with: size, options: NSStringDrawingOptions.truncatesLastVisibleLine, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: CGFloat(ToastFontSize))], context: nil);
        return rect.width + 2
    }
    
    fileprivate class func getInfoHeight(info:String,width:CGFloat) -> CGFloat {
        let size = CGSize.init(width: width, height: 1000)
        let rect = info.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: CGFloat(ToastFontSize))], context: nil);
        return rect.height
    }

}
