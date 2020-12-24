//
//  BaseViewModel.swift
//  LDD
//
//  Created by west on 2018/5/25.
//  Copyright © 2018年 上海牧客网络科技有限公司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBlocking
import Moya

enum RequestStatus {
    case none
    case start /* 请求开始 */
    case finish /* 请求结束 */
    case errorRepeat /* 网络请求错误，一般需要 点击刷新的页面会调用 */
    case errorCode /* 返回数据 code 值不为 1 */

}

class BaseViewModel {
    /* rxswift 资源回收 */
    let disposeBag = DisposeBag()

    var requestSuccess = BehaviorRelay(value: false) //请求接口返回结果 code == 1
    var requestError = BehaviorRelay(value: false) //请求接口错误 无code值
    var refreshSource = BehaviorRelay(value: false) //有新值 通知
    var requestStatus = BehaviorRelay(value: RequestStatus.none) //请求状态（用于请求提示）
    
    deinit { print("\(self) -- ViewModel -- 释放")}
}


class ListViewModel<T:MapJson>: BaseViewModel {
    var currentPage = 1
    var dataList = [T]()
    
    var loadover = BehaviorRelay(value: false) //通知数据已经全部请求完成
    private var isLoadover = false //标示是否数据已经全部请求

    /* 请求首页 */
    func getFirstPage(){
        dataList.removeAll()
        currentPage = 1
        isLoadover = false
        getList()
    }
    
    /* 请求下一页 */
    func getNextPage(){
        guard isLoadover == false else{ return }
        currentPage += 1
        getList()
    }
    
    /* 由子类继承实现请求列表 */
    public func getList(){}
    
    /* 数据列表全部加载 */
    func setLoadover(over:Bool) {
        isLoadover = over
        loadover.accept(over)
    }
}
