//
//  ApiTarget+Default.swift
//  LCCFD
//
//  Created by west on 2018/1/19.
//  Copyright © 2018年 west. All rights reserved.
//

import Foundation
import Moya

typealias RequestApiProtocol = RequestApiConfig & TargetType

protocol RequestApiConfig {
    
}

extension TargetType{
    var baseURL: URL {
        return URL.init(string: "https://api.github.com/")!
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    var headers: [String : String]? {
        return ["Accept":"application/json",
                "Content-Type":"application/x-www-form-urlencoded; charset=utf-8",
                "Connection":"keep-alive"]
    }
}


