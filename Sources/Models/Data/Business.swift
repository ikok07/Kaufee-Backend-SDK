//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 28.01.24.
//

import Foundation

struct Business: Codable {
    let userId: String
    let name: String
    let description: String
    let products: BusinessProducts
    let metadata: BusinessMetadata
}

struct BusinessProducts: Codable {
    let businessId: String
    let name: String
    let description: String
    let price: Double
    let currency: String
    let metadata: BusinessMetadata
}

struct BusinessMetadata: Codable {
    let creation: Date
}
