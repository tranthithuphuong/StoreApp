//
//  OrderAPI.swift
//  STORE
//
//  Created by chuottp on 02/02/2023.
//

import Foundation
import Alamofire

class OrderAPI {
    
    func getOrder(Id: Int, completion: @escaping (Ordered) -> ()){
        print("somthing")
        AF.request("http://localhost:3000/order?id=\(Id)", method: .get).responseDecodable(of: Ordered.self){
               (response) in
               if let ordersResponse = response.value{
                   completion(ordersResponse)
               }
           }
       }
    
    func createOrder(ordered: Order){
        AF.request("http://localhost:3000/order/create/", method: .post, parameters: ordered,encoder: JSONParameterEncoder.default).responseDecodable(of: Order.self){
               (response) in
               if let ordersResponse = response.value{
                   print(ordersResponse)
               }
           }
       }
    
    func getOrderDetail(Id: Int, completion: @escaping (OrderDetails) -> ()){
        print("somthing")
        AF.request("http://localhost:3000/orderDetail?id=\(Id)", method: .get).responseDecodable(of: OrderDetails.self){
               (response) in
               if let orderDetailsResponse = response.value{
                   completion(orderDetailsResponse)
               }
           }
       }

}
