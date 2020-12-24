//
//  RequestMapModel.swift
//  MM
//
//  Created by 上海牧客网络科技有限公司 on 2017/10/31.
//  Copyright © 2017年 上海牧客网络科技有限公司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBlocking
import RxCocoaRuntime
import Moya
import RxMoya
import HandyJSON

extension ObservableType where Element == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { Observable.just($0.mapModelResponse(T.self)) }
    }
}

extension ObservableType where Element : HandyJSON {
    /* 持有请求结果，统一处理请求出错 */
    func response(onNext: ((Self.Element) -> Void)? = nil, onError: ((Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil, isShowError: Bool? = true, isHiddenActivity: Bool? = true) -> Disposable{
        return self.subscribe(onNext: { (respone) in
            print(respone)
            onNext?(respone)
        }, onError: { (error) in
            onError?(error)
        }, onCompleted: {
            onCompleted?()
        }) {
            onDisposed?()
        }
    }
}

extension Response {
    func mapModelResponse<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonStr = getResponseJsonStr()
        if let model = JSONDeserializer<T>.deserializeFrom(json: jsonStr) {
            if let map = model.toJSON(){
                filterResponse(result: map)
            }
            return model
        }else{
            let resultStr = "{\"code\":\"404\",\"msg\":\"网络请求失败\"}"
            return JSONDeserializer<T>.deserializeFrom(json: resultStr)!
        }
    }
    
    fileprivate func getResponseJsonStr() -> String{
        guard statusCode == 200 else {
            let resultStr = "{\"code\":\(statusCode),\"msg\":\"\(description)\"}"
            return resultStr
        }
        guard let jsonString = String.init(data: self.data, encoding: .utf8) else{
            let resultStr = "{\"code\":10,\"msg\":\"返回数据解析失败\"}"
            return resultStr
        }
        return jsonString
    }
    
    fileprivate func filterResponse(result:[String:Any]) {

    }
}

