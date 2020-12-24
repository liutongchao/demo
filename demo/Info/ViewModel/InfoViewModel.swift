//
//  InfoViewModel.swift
//  demo
//
//  Created by west on 24/12/20.
//

import Foundation

class InfoViewModel: BaseViewModel {
    
}

extension InfoViewModel{
    func getInfo() {
        Request.info.post(api: .getInfo)
            .mapModel(Model<EmptyModel>.self)
            .response(onNext: { [unowned self](model) in
                if model.code == 1{
                    self.refreshSource.accept(true)
                }else{
                    LCToastView.showGlobalToast(info: model.msg)
                }
                self.requestStatus.accept(.finish)
            })
            .disposed(by: disposeBag)
    }
   
}
