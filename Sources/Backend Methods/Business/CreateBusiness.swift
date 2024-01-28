//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 28.01.24.
//

import SwiftUI
import NetworkRequests
import JSONCoder

extension Backend {
    
    public func createBusiness(image: Image?, name: String, description: String, token: String, callback: (Result<CreateBusinessResponse, BackendError<String>>) async -> Void) async {
        guard let config else {
            await callback(.failure(K.SDKError.noConfigError))
            return
        }
        
        let jsonData = JSONCoder.encode(CreateBusinessRequest(name: name, description: description))
        let uiImage = ImageRenderer(content: image).uiImage
        
        let request: Result<CreateBusinessResponse, NetworkError>? = await Request.formData(
            httpMethod: "POST",
            url: "\(config.baseUrl)/en/api/v1/business",
            json: jsonData,
            image: uiImage,
            authToken: token
        )
        
        guard let request else {
            await callback(.failure(K.SDKError.noAPIConnectionError))
            return
        }
        
        switch request {
        case .success(let response):
            if response.status == "success" {
                await callback(.success(response))
            } else {
                await callback(.failure(
                    config.getError(.CouldNotCreateBusiness) ??
                    BackendError(
                        type: .Custom,
                        localizedDescription: response.message ??
                        K.SDKError.noAPIConnectionError.localizedDescription)
                ))
            }
        case .failure(let error):
            await callback(.failure(BackendError(type: .Custom, localizedDescription: error.localizedDescription)))
        }
        
    }
    
}
