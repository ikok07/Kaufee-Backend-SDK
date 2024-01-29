//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 29.01.24.
//

import Foundation

public struct GetAllBusinessesResponse: Codable {
    public let status: String
    public let results: Int?
    public let data: GetAllBusinessesData?
    public let message: String?
    public let identifier: String?
}

public struct GetAllBusinessesData: Codable {
    public let businesses: [Business]
}
