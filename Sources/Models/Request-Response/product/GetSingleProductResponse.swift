//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 31.01.24.
//

import Foundation

public struct GetSingleProductResponse: Codable {
    public let status: String
    public let data: GetSingleProductData?
    public let message: String?
    public let identifier: String?
}

public struct GetSingleProductData: Codable {
    public let product: BusinessProduct
}
