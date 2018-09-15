//
//  NetworkDispatcher.swift
//  groby
//
//  Created by 이재성 on 26/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void)
}

struct URLSessionNetworkDispatcher: NetworkDispatcher {
    static let instance = URLSessionNetworkDispatcher()
    private init() {}

    static func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {

    }

    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: request.path) else {
            onError(ConnError.invalidURL)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json; charset=UTF-8;", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = request.method.rawValue

        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                onError(error)
                return
            }

            guard let _data = data else {
                onError(ConnError.noData)
                return
            }

            onSuccess(_data)
        }.resume()
    }
}
