//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 28.01.24.
//

import Foundation
import NetworkRequests

extension Backend {
    
    public func deleteBusiness(businessId: String, token: String, callback: (Result<BackendEmptyResponse, BackendError<String>>) async -> Void) async {
        guard let config else {
            await callback(.failure(K.SDKError.noConfigError))
            return
        }
        
        let request: Result<BackendEmptyResponse, NetworkError>? = await Request.delete(url: "\(config.baseUrl)/en/api/v1/business/\(businessId)", authToken: token)
        
        guard let request else {
            await callback(.failure(K.SDKError.noAPIConnectionError))
            return
        }
        
        switch request {
        case .success(let response):
            if response.status == "success" {
                await callback(.success(response))
            } else {
                await callback(.failure(config.getError(.CouldNotDeleteBusiness) ?? K.SDKError.noAPIConnectionError))
            }
        case .failure(let error):
            await callback(.failure(config.getError(.CouldNotDeleteBusiness) ?? BackendError(type: .Custom, localizedDescription: error.localizedDescription)))
        }
    }
    
}
