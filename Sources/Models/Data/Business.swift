//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 28.01.24.
//

import Foundation

public struct Business: Codable, Hashable {
    public let userId: String
    public let image: String
    public let name: String
    public let description: String
    public let products: [BusinessProduct]
    public let metadata: BusinessMetadata
    
    public init(userId: String, image: String, name: String, description: String, products: [BusinessProduct], metadata: BusinessMetadata) {
        self.userId = userId
        self.image = image
        self.name = name
        self.description = description
        self.products = products
        self.metadata = metadata
    }
}

public struct BusinessProduct: Codable, Hashable {
    public let businessId: String
    public let name: String
    public let description: String
    public let price: Double
    public let currency: String
    public let metadata: BusinessMetadata
    
    public init(businessId: String, name: String, description: String, price: Double, currency: String, metadata: BusinessMetadata) {
        self.businessId = businessId
        self.name = name
        self.description = description
        self.price = price
        self.currency = currency
        self.metadata = metadata
    }
}

public struct BusinessMetadata: Codable, Hashable {
    public let creation: Date
    
    public init(creation: Date) {
        self.creation = creation
    }
}
