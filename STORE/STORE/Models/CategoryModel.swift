//
//  CategoryModel.swift
//  STORE
//
//  Created by chuottp on 14/01/2023.
//

import Foundation

// MARK: - CategoryElement
struct Category: Codable {
    let maDanhMuc, tenDanhMuc: String

    enum CodingKeys: String, CodingKey {
        case maDanhMuc = "ma_danh_muc"
        case tenDanhMuc = "ten_danh_muc"
    }
}

typealias Categories = [Category]
