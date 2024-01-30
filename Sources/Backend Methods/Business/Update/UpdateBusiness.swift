//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import Foundation
import NetworkRequests

extension Backend {
    
    public func updateBusiness(userId: String, businessId: String, token: String, callback: (Result<ModifyBusinessResponse, BackendError<String>>) async -> Void) async {
        guard let config else {
            await callback(.failure(K.SDKError.noConfigError))
            return
        }
        
        let request: Result<ModifyBusinessResponse, NetworkError> = await Request.formData(httpMethod: "PATCH", url: "\(config.baseUrl)/en/api/v1/user/\(userId)/business/\(businessId)", authToken: token)
        
        switch request {
        case .success(let response):
            if response.status == "success" {
                await callback(.success(response))
            } else {
                await callback(.failure(
                    config.getError(.CouldNotUpdateBusiness) ??
                    BackendError(type: .Custom, localizedDescription: response.message ?? K.SDKError.noAPIConnectionError.localizedDescription)
                ))
            }
        case .failure(let error):
            await callback(.failure(
                config.getError(.CouldNotLoadSingleBusiness) ??
                BackendError(type: .Custom, localizedDescription: error.localizedDescription)
            ))
        }
    }
    
}
