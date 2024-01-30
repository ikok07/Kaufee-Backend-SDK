//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import UIKit
import NetworkRequests
import JSONCoder

extension Backend {
    
    public func updateBusiness(name: String, description: String, image: UIImage, userId: String, businessId: String, token: String, callback: (Result<ModifyBusinessResponse, BackendError<String>>) async -> Void) async {
        guard let config else {
            await callback(.failure(K.SDKError.noConfigError))
            return
        }
        
        let jsonData = JSONCoder.encode(ModifyBusinessRequest(name: name, description: description))
        
        let request: Result<ModifyBusinessResponse, NetworkError> = await Request.formData(
            httpMethod: "PATCH",
            url: "\(config.baseUrl)/en/api/v1/user/\(userId)/business/\(businessId)",
            json: jsonData,
            image: image,
            authToken: token
        )
        
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
