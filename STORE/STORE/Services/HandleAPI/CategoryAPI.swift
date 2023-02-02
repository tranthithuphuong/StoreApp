//
//  CategoryAPI.swift
//  STORE
//
//  Created by chuottp on 14/01/2023.
//

import Foundation
import Alamofire

class CategoryAPI {
    func getCategories(completion: @escaping (Categories) -> ()) {
        AF.request("http://localhost:3000/category/", method: .get).responseDecodable(of: Categories.self) { (response) in
            if let categoriesResponse = response.value {
                completion(categoriesResponse)
            }
        }
    }

}
