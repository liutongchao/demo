//
//  BaseModel.swift
//  LDD
//
//  Created by west on 2018/5/25.
//  Copyright © 2018年 上海牧客网络科技有限公司. All rights reserved.
//

import Foundation
import HandyJSON

typealias MapJson = HandyJSON
class Model<T:HandyJSON>: HandyJSON {
    var code = 0  /* 状态值 */
    var msg = "" /* 状态描述 */
    var data:T?
    
    required init() {}
    
    deinit { print("\(self) -- Model -- 释放")}
}
class ListModel<T:HandyJSON>: HandyJSON {
    var code = 0  /* 状态值 */
    var msg = "" /* 状态描述 */
    var data = [T]()
    
    required init() {}
    deinit { print("\(self) -- ListModel -- 释放")}
}

struct EmptyModel: HandyJSON {}

extension Int: HandyJSON{}
extension Bool: HandyJSON{}
extension Float: HandyJSON{}
extension Double: HandyJSON{}
extension String: HandyJSON{}
extension Dictionary: HandyJSON{}





