//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 28.01.24.
//

import Foundation

public struct Business: Codable, Hashable {
    public let _id: String
    public let userId: String
    public let photo: String
    public let name: String
    public let description: String
    public let products: [BusinessProduct]
    public let metadata: BusinessMetadata
    
    public init(_id: String, userId: String, photo: String, name: String, description: String, products: [BusinessProduct], metadata: BusinessMetadata) {
        self._id = _id
        self.userId = userId
        self.photo = photo
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
    public let creation: String
    
    public init(creation: String) {
        self.creation = creation
    }
}
