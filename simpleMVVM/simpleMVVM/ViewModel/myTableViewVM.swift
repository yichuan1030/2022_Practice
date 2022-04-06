//
//  myTableViewVM.swift
//  simpleMVVM
//
//  Created by raymondwang on 2022/3/28.
//

import Foundation

class myTableViewVM : NSObject {
    
    let apiSvc : APIServiceProtocol
    var showAlertClosure : ((_ msg: String?) -> ())? // alert closure
    var updateLoadingStatus : (()->())?
    var reloadTableViewClosure : (() -> ())?
    var isLoading : Bool? {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var serverData : [itemData] = [itemData]()
    var serverBeerData : [beerData] = [beerData]()
    var tableViewData : [tableViewCellData] = [tableViewCellData]()
    
    
    init(apiSvc :  APIServiceProtocol = APIService()) {
        self.apiSvc = apiSvc
    }
    
    
    func initFetch() {
        self.isLoading = true
        
        apiSvc.fetchServerData { [weak self] (success, uData, err) in
            self?.isLoading = false
            if let err = err {
                self?.showAlertClosure?(err.rawValue)
            }else{
                self?.processFetchedData(uData)
            }
        }
        
    }
    
    func initBeerFetch() {
        self.isLoading = true
        
        apiSvc.fetchBearServerData(complete: { [weak self] (success, uData, err) in
            self?.isLoading = false
            if let err = err {
                self?.showAlertClosure?("error")
            }else{
                self?.processFetchedData(uData)
            }
        })
        
    }
    
    // MARK: Public API
    func processFetchedData(_ data : [itemData]) {
        serverData = data
        
        var tableDataArr = [tableViewCellData]()
        for item in data {
            
            var tableData = tableViewCellData()
            tableData.title = item.name
            tableData.content = item.description
            tableData.url = item.image_url
            tableData.img = item.image_url
            
            tableDataArr.append(tableData)
        }
        tableViewData = tableDataArr
        self.reloadTableViewClosure?()
    }
    
    func processFetchedData(_ data : [beerData]) {
        serverBeerData = data
        
        var tableDataArr = [tableViewCellData]()
        for item in data {
            
            var tableData = tableViewCellData()
            tableData.title = item.name
            tableData.content = item.id
//            tableData.url = item.image_url
            tableData.img = catUrl
            
            tableDataArr.append(tableData)
        }
        tableViewData = tableDataArr
        self.reloadTableViewClosure?()
    }
    
    func getDataCount() -> Int {
        return tableViewData.count
    }
    
    func getCellData(ip: IndexPath) -> tableViewCellData {
        return tableViewData[ip.row]
    }
    
    func cellSelect(ip:IndexPath) {
        let selectCell = getCellData(ip: ip)
        self.showAlertClosure?(selectCell.title)
    }
    
}

