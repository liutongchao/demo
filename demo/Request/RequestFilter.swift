//
//  RequestFilter.swift
//  LCCFD
//
//  Created by 上海牧客网络科技有限公司 on 2017/12/20.
//  Copyright © 2017年 上海牧客网络科技有限公司. All rights reserved.
//

import Foundation
import RxSwift
//import RxCocoa
import Moya
import RxMoya
import HandyJSON
//import Result
import Alamofire

struct RequestFilter {
    let disposeBag = DisposeBag()
    
    fileprivate func requestLog(response:Response){
        #if DEBUG
            guard let request = response.request,
                    let url = request.url else {
                return
            }
            let host = url.absoluteString
            print("🍋地址:" + host)
            if let data = request.httpBody,
                let dataStr = String.init(data: data, encoding: String.Encoding.utf8) {
                print("🥝参数:" + dataStr)
            }
            if let jsonString = String.init(data: response.data, encoding: .utf8){
                print("🍏结果:" + jsonString.prefix(10000))
            }else{
                let resultStr = "{\"status\":\(response.statusCode),\"result\":\"\(response.description)\"}"
                print("🍎结果:\(resultStr)")
            }
        #endif
    }
}

extension RequestFilter: PluginType{
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        let req = request
        return req
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
            case .success(let response):
                requestLog(response: response)
            case .failure(let error):
                if let response = error.response{
                    requestLog(response: response)
                }
        }
    }
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        return result
    }
}

