//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 31.01.24.
//

import SwiftUI
import NetworkRequests
import JSONCoder

extension Backend {
    
    public func updateProduct(
        userId: String,
        businessId: String,
        productId: String,
        token: String,
        name: String,
        description: String,
        price: Double,
        currency: String,
        image: Image?,
        callback: ((Result<GetSingleProductResponse, BackendError<String>>) async -> Void)
    ) async {
        guard let config else {
            await callback(.failure(K.SDKError.noConfigError))
            return
        }
        
        let jsonData = JSONCoder.encode(ModifyProductRequest(name: name, description: description, price: price, currency: currency))
        let uiImage = ImageRenderer(content: image).uiImage
        
        let request: Result<GetSingleProductResponse, NetworkError> = await Request.formData(httpMethod: "PATCH", url: "\(config.baseUrl)/en/api/v1/user/\(userId)/business/\(businessId)/products/\(productId)", json: jsonData, image: uiImage, authToken: token)
        
        switch request {
        case .success(let response):
            if response.status == "success" {
                await callback(.success(response))
            } else {
                await callback(.failure(
                    config.getError(.CouldNotUpdateSingleProduct) ??
                    BackendError(type: .Custom, localizedDescription: response.message ?? K.SDKError.noAPIConnectionError.localizedDescription)
                ))
            }
        case .failure(let error):
            await callback(.failure(
                config.getError(.CouldNotUpdateSingleProduct) ??
                BackendError(type: .Custom, localizedDescription: error.localizedDescription)
            ))
        }
        
    }
    
}
