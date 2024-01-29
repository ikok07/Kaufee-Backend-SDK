//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 29.01.24.
//

import Foundation

public struct GetAllBusinessesResponse: Codable {
    let status: String
    let results: Int?
    let data: GetAllBusinessesData?
    let message: String?
    let identifier: String?
}

public struct GetAllBusinessesData: Codable {
    let businesses: [Business]
}
