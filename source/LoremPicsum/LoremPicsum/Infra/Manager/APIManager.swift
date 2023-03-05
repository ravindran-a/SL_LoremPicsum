//
//  APIManager.swift
//  LoremPicsum
//
//  Created by Ravindran on 05/03/23.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class APIManager {
    static let shared: APIManager = APIManager()
    
    private var session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    private func getRequest(serviceURL: String, httpMethod: HttpMethod = .get) -> URLRequest? {
        var requestURL: String = ""
        if !serviceURL.contains("http") {
            requestURL = getFullEndpointUrl(serviceUrl: serviceURL)
        } else {
            requestURL = serviceURL.urlEncoded ?? serviceURL
        }
        guard let url: URL = URL(string: "\(requestURL)") else {
            return nil
        }
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
    func request(serviceURL: String, httpMethod: HttpMethod = .get) async throws -> (Data, URLResponse) {
        let request: URLRequest? = getRequest(serviceURL: serviceURL, httpMethod: httpMethod)
        return try await makeApiCall(request: request)
    }
    
    private func makeApiCall(request: URLRequest?) async throws -> (Data, URLResponse) {
        guard let confirmedRequest = request else {
            throw APIError.runtimeError("Failed to create request")
        }
        return try await withCheckedThrowingContinuation { continuation in
            let sessionTask: URLSessionDataTask = self.session.dataTask(with: confirmedRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error: Error = error {
                        continuation.resume(throwing: error)
                    } else {
                        guard let confirmedData = data, let confirmedResponse = response else {
                            continuation.resume(throwing: APIError.runtimeError("Failed to receive API response"))
                            return
                        }
                        continuation.resume(returning: (confirmedData, confirmedResponse))
                    }
                }
            }
            sessionTask.resume()
        }
    }
    
    private func getFullEndpointUrl(serviceUrl: String) -> String {
        return (APIEndPoints.ApiBaseUrl + serviceUrl).urlEncoded ?? (APIEndPoints.ApiBaseUrl + serviceUrl)
    }
    
}
