//
//  APIService.swift
//  simpleMVVM
//
//  Created by raymondwang on 2022/3/29.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func fetchServerData(complete: @escaping ( _ success: Bool, _ uData:[itemData], _ err: APIError? )->() )
}

class APIService : APIServiceProtocol {
    func fetchServerData(complete: @escaping (Bool, [itemData], APIError?) -> ()) {

        DispatchQueue.global().async {
            sleep(3) // simulate server delay
            guard let path = Bundle.main.path(forResource: "serverData", ofType: "json") else {
                complete(false, [], APIError.permissionDenied)
                return
            }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let serverData = try decoder.decode(serverData.self, from: data)
                complete( true, serverData.userData, nil )
            } catch {
                complete(false, [], APIError.serverOverload)
            }
        }
        
//        DispatchQueue.global().async {
//            sleep(3)
//            if let path = Bundle.main.path(forResource: "serverData", ofType: "json"){
//                let data = try! Data(contentsOf: URL(fileURLWithPath: path))
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
//                let serverDATA = try! decoder.decode(serverData.self, from: data)
//                complete( true, serverDATA.userData, nil )
//            }
//            
//        }
        
    }
}
