//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 31.01.24.
//

import Foundation

public struct ModifyProductRequest: Codable {
    let name: String
    let description: String
    let price: Double
    let currency: String
}
