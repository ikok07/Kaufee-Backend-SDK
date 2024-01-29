//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 29.01.24.
//

import Foundation
import NetworkRequests

extension Backend {
    
    public func getBusinesses(token: String, callback: (Result<GetAllBusinessesResponse, BackendError<String>>) async -> Void) async {
        guard let config else {
            await callback(.failure(K.SDKError.noConfigError))
            return
        }
        
        let request: Result<GetAllBusinessesResponse, NetworkError> = await Request.get(url: "\(config.baseUrl)/en/api/v1/business", authToken: token)
        
        switch request {
        case .success(let response):
            if response.status == "success" {
                await callback(.success(response))
            } else {
                await callback(.failure(
                    config.getError(.CouldNotLoadBusinesses) ??
                    BackendError(type: .Custom,
                                 localizedDescription: response.message ?? K.SDKError.noAPIConnectionError.localizedDescription)
                ))
            }
        case .failure(let error):
            await callback(.failure(BackendError(type: .Custom, localizedDescription: error.localizedDescription)))
        }
    }
    
}
