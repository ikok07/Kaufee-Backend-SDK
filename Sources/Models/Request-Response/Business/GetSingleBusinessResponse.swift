//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import Foundation

public struct GetSingleBusinessResponse: Codable {
    public let status: String
    public let data: GetSingleBusinessData?
    public let message: String?
    public let identifier: String?
}

public struct GetSingleBusinessData: Codable {
    public let business: Business
}
