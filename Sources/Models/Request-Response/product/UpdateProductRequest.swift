//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 31.01.24.
//

import Foundation

public struct UpdateProductRequest: Codable {
    let name: String
    let description: String
    let price: Double
    let currency: String
}
