//
//  myTableViewCellModel.swift
//  simpleMVVM
//
//  Created by raymondwang on 2022/3/28.
//

import Foundation

class myTableViewCellVM : NSObject {
    
    let apiSvc : APIServiceProtocol
    var showAlertClosure : (() -> ())? // alert closure
    
    
    init(apiSvc :  APIServiceProtocol = APIService()) {
        self.apiSvc = apiSvc
    }
    

}

