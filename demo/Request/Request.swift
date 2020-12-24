//
//  Request.swift
//  POP协议编程
//
//  Created by 上海牧客网络科技有限公司 on 2017/3/3.
//  Copyright © 2017年 上海牧客网络科技有限公司. All rights reserved.
//

import Foundation
import RxSwift
//import RxCocoa
import Moya
import RxMoya

struct Request {    
    //各个server
    static let info = RequestProvider<InfoApi>() /* 请求信息模块 */
   
}

struct RequestProvider<Sever:TargetType>{
    
    let share = MoyaProvider<Sever>(plugins: [RequestFilter()])

    func post(api:Sever) -> Observable<Response>{
        return share.rx.request(api).asObservable()
    }
        
    /* 上传带进度 */
    func upload(api:Sever) -> Observable<ProgressResponse>{
        return share.rx.requestWithProgress(api).asObservable()
    }

    /* 下载带进度 */
    func dowload(api:Sever) -> Observable<ProgressResponse>{
        return share.rx.requestWithProgress(api).asObservable()
    }
}
