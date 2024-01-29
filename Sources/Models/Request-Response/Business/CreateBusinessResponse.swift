//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 28.01.24.
//

import Foundation

public struct CreateBusinessResponse: Codable {
    public let status: String
    public let data: CreateBusinessData?
    public let message: String?
    public let identifier: String?
}

public struct CreateBusinessData: Codable {
    public let business: Business
}