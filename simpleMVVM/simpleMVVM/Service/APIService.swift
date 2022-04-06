//
//  APIService.swift
//  simpleMVVM
//
//  Created by raymondwang on 2022/3/29.
//

import Foundation
import SwiftUI

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func fetchServerData(complete: @escaping ( _ success: Bool, _ uData:[itemData], _ err: APIError? )->() )
    
    func fetchBearServerData(complete: @escaping ( _ success: Bool, _ uData:[beerData], _ err: Error? )->() )
}

class APIService : APIServiceProtocol {

    
    func fetchServerData(complete: @escaping (Bool, [itemData], APIError?) -> ()) {

        DispatchQueue.global().async {
            sleep(2) // simulate server delay
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
    }
        
    func fetchBearServerData(complete: @escaping (Bool, [beerData], Error?) -> ()) {
        let url = "https://api.openbrewerydb.org/breweries"
        if let url = URL(string: url) {
            
            let urlSession = URLSession.init(configuration: .default).dataTask(with: url) { data, urlRes, err in
                
                guard err == nil else {
                    return complete(false, [], err)
                }
                
                guard let data = data else {
                    return complete( false, [], err )
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodeBeerData = try decoder.decode([beerData].self, from: data)
                    complete( true, decodeBeerData, err )
                } catch {
                    complete( false, [], err )
                }
            }
            urlSession.resume()
            
        }
//        URLSession.shared.dataTaskPublisher(for: URL(string: url)!)

    }
    
}
