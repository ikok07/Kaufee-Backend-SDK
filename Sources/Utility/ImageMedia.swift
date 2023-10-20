//
//  ImageMedia.swift
//
//
//  Created by Martin on 20.10.23.
//

import Foundation
import UIKit

struct ImageMedia: Codable {
    let key: String
    let data: Data?
    let mimeType: String
    
    init(withImage image: UIImage?, key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.data = image?.jpegData(compressionQuality: 0.3)
    }
}
