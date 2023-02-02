//
//  OrderMoldel.swift
//  STORE
//
//  Created by chuottp on 02/02/2023.
//

import Foundation
struct Orders: Codable {
    let maDonHang, maNguoiDung: Int
    let tongTien, trangThai, taoLuc: String

    enum CodingKeys: String, CodingKey {
        case maDonHang = "ma_don_hang"
        case maNguoiDung = "ma_nguoi_dung"
        case tongTien = "tong_tien"
        case trangThai = "trang_thai"
        case taoLuc = "tao_luc"
    }
}

typealias Ordered = [Orders] //:Đ
