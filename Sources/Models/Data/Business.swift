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
    public var products: [BusinessProduct]
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
    public let _id: String
    public let businessId: String
    public let photo: String
    public let name: String
    public let description: String
    public let price: Double
    public let currency: String
    public let metadata: BusinessMetadata
    
    public init(_id: String, businessId: String, photo: String, name: String, description: String, price: Double, currency: String, metadata: BusinessMetadata) {
        self._id = _id
        self.businessId = businessId
        self.photo = photo
        self.name = name
        self.description = description
        self.price = price
        self.currency = currency
        self.metadata = metadata
    }
}

public struct BusinessMetadata: Codable, Hashable {
    public let creation: Double
    
    public var realCreationDate: Date {
        return Date(timeIntervalSince1970: creation / 1000)
    }
    
    public init(creation: Double) {
        self.creation = creation
    }
}
