//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 1.02.24.
//

import SwiftUI
import NetworkRequests

extension Backend {
    
    public func createProduct(
        name: String,
        description: String,
        price: String,
        currency: String,
        image: Image?,
        userId: String,
        businessId: String,
        token: String,
        callback: (Result<GetSingleProductResponse, BackendError<String>>) async -> Void
    ) async {
        guard let config else {
            await callback(.failure(K.SDKError.noConfigError))
            return
        }
        
        let request: Result<GetSingleProductResponse, NetworkError> = await Request.formData(httpMethod: "POST", url: "\(config.baseUrl)/en/api/v1/user/\(userId)/business/\(businessId)/products")
        
        switch request {
        case .success(let response):
            if response.status == "success" {
                await callback(.success(response))
            } else {
                await callback(.failure(
                    config.getError(.CouldNotCreateSingleProduct) ??
                    BackendError(type: .Custom, localizedDescription: response.message ?? K.SDKError.noAPIConnectionError.localizedDescription)
                ))
            }
        case .failure(let error):
            await callback(.failure(
                config.getError(.CouldNotCreateSingleProduct) ??
                BackendError(type: .Custom, localizedDescription: error.localizedDescription)
            ))
        }
        
    }
    
}
