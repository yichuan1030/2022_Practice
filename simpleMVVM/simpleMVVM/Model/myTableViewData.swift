//
//  myTableViewCellData.swift
//  simpleMVVM
//
//  Created by raymondwang on 2022/3/29.
//

import Foundation


struct serverData : Codable {
    var userData: [itemData]
}


struct itemData : Codable {
    var id : String?
    var user_id : String?
    var name : String?
    var description : String?
    var image_url : String?
}

//struct tableViewCellData : Codable {
//    var title : String?
//    var content : String?
//    var url : String?
//    var img : String?
//}
