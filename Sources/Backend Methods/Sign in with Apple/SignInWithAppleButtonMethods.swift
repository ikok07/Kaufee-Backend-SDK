//
//  File.swift
//  
//
//  Created by Kaloyan Petkov on 16.01.24.
//

import SwiftUI
import AuthenticationServices

extension Backend {
    
    
    public func setSignInWithAppleRequestVariables(_ request: ASAuthorizationAppleIDRequest) -> ASAuthorizationAppleIDRequest? {
        guard self.config != nil else {
            return nil
        }
        
        let nonce = Nonce()
        let state = Nonce()
        
        backendVariables.signInWithAppleNonce = nonce
        backendVariables.signInWithAppleState = state
        
        request.requestedScopes = [.fullName, .email]
        request.nonce = nonce.description
        request.state = state.description
        return request
    }
    
    public func completeSignInWithApple(result: Result<ASAuthorization, Error>, callback: (Result<SignInWithAppleResponse, BackendError<String>>) async -> Void) async {
        guard self.config != nil else {
            await callback(.failure(K.SDKError.noConfigError))
            return
        }
        
        switch result {
        case .success(let authResults):
            switch authResults.credential {
            case let credential as ASAuthorizationAppleIDCredential:
                var name: String?
                if let firstName = credential.fullName?.givenName, let lastName = credential.fullName?.familyName {
                    name = "\(firstName) \(lastName)"
                }
                
                await performSignInWithAppleAuthorization(
                    appleUserId: credential.user,
                    name: name,
                    email: credential.email,
                    status: credential.realUserStatus,
                    authorizationCode: credential.authorizationCode,
                    nonceString: backendVariables.signInWithAppleNonce?.description,
                    identityToken: credential.identityToken) { result in
                        switch result {
                        case .success(let response):
                            await callback(.success(response))
                        case .failure(let error):
                            await callback(.failure(
                                config!.getError(.SignInWithAppleFailed) ?? BackendError(type: .Custom, localizedDescription: error.localizedDescription))
                            )
                        }
                    }
            default:
                await callback(.failure(
                    config!.getError(.SignInWithAppleFailed) ?? K.SDKError.noAPIConnectionError)
                )
            }
        case .failure(let error):
            print("Sign In With Apple authorisation failed: \(error.localizedDescription)")
            await callback(.failure(
                config!.getError(.SignInWithAppleFailed) ?? K.SDKError.noAPIConnectionError)
            )
        }
    }
}