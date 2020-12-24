//
//  InfoApi.swift
//  demo
//
//  Created by west on 24/12/20.
//

import Foundation
import Moya

enum InfoApi {
    case getInfo /* 获取接口信息 */
}


extension InfoApi: RequestApiProtocol{
    var path: String {
        return ""
    }
    var task: Moya.Task {
         return  .requestPlain
    }
}
