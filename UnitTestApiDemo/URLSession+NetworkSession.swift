//
//  URLSession+NetworkSession.swift
//  UnitTestApiDemo
//
//  Created by Ganesh on 12/07/23.
//

import Foundation

protocol NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping (Data?, Int, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping (Data?, Int, Error?) -> Void) {
        let task = dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(data, 0, error)
                return
            }
            
            completionHandler(data, httpResponse.statusCode, error)
        }

        task.resume()
    }
}
