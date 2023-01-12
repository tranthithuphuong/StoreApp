//
//  ProductAPI.swift
//  STORE
//
//  Created by chuottp on 11/01/2023.
//

import Foundation
import Alamofire

class ProductAPI {
    func getProducts(completion: @escaping (Products) -> ()) {
        AF.request("http://localhost:3000/product/", method: .get).responseDecodable(of: Products.self) { (response) in
            if let productsResponse = response.value {
                completion(productsResponse)
            }
        }
}
}
