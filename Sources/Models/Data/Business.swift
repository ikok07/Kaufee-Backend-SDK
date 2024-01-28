//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 28.01.24.
//

import Foundation

public struct Business: Codable, Hashable {
    public let userId: String
    public let name: String
    public let description: String
    public let products: BusinessProducts
    public let metadata: BusinessMetadata
}

public struct BusinessProducts: Codable, Hashable {
    public let businessId: String
    public let name: String
    public let description: String
    public let price: Double
    public let currency: String
    public let metadata: BusinessMetadata
}

public struct BusinessMetadata: Codable, Hashable {
    public let creation: Date
}
