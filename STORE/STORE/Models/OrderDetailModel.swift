//
//  OrderDetailModel.swift
//  STORE
//
//  Created by chuottp on 02/02/2023.
//

import Foundation
struct OrderDetail: Codable {
    let maThongTinDonHang, maDonHang: Int
    let anhSANPham, tenSANPham: String
    let maSANPham: Int
    let giaTien: String

    enum CodingKeys: String, CodingKey {
        case maThongTinDonHang = "ma_thong_tin_don_hang"
        case maDonHang = "ma_don_hang"
        case anhSANPham = "anh_san_pham"
        case tenSANPham = "ten_san_pham"
        case maSANPham = "ma_san_pham"
        case giaTien = "gia_tien"
    }
}

typealias OrderDetails = [OrderDetail]
