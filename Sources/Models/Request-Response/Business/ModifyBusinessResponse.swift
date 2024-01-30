//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 28.01.24.
//

import Foundation

public struct ModifyBusinessResponse: Codable {
    public let status: String
    public let data: ModifyBusinessData?
    public let message: String?
    public let identifier: String?
}

public struct ModifyBusinessData: Codable {
    public let business: Business
}
