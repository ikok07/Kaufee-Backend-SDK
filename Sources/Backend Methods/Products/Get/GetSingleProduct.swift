//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 31.01.24.
//

import Foundation
import NetworkRequests

extension Backend {
    
    public func getSingleProduct(userId: String, businessId: String, productId: String, token: String, callback: ((Result<GetSingleProductResponse, BackendError<String>>) async -> Void)) async {
        guard let config else {
            await callback(.failure(K.SDKError.noConfigError))
            return
        }
        
        let request: Result<GetSingleProductResponse, NetworkError> = await Request.get(url: "\(config.baseUrl)/en/api/v1/user/\(userId)/business/\(businessId)/products/\(productId)", authToken: token, showRawResponseData: true)
        
        switch request {
        case .success(let response):
            if response.status == "success" {
                await callback(.success(response))
            } else {
                await callback(.failure(
                    config.getError(.CouldNotLoadSingleProduct) ??
                    BackendError(type: .Custom, localizedDescription: response.message ?? K.SDKError.noAPIConnectionError.localizedDescription)
                ))
            }
        case .failure(let error):
            await callback(.failure(
                config.getError(.CouldNotLoadSingleProduct) ??
                BackendError(type: .Custom, localizedDescription: error.localizedDescription)
            ))
        }
        
    }
    
}
