//
//  myTableViewData.swift
//  simpleMVVM
//
//  Created by raymondwang on 2022/3/29.
//

import Foundation
import UIKit

// MARK: Server Data
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

// MARK: Server Beer Data
struct beerData : Codable {
    var id : String?
    var name : String?
}

// MARK: UI cell Data
struct tableViewCellData : Codable {
    var title : String? // name
    var content : String? // desc
    var url : String? // imgUrl
    var img : String? // imgUrl
}

