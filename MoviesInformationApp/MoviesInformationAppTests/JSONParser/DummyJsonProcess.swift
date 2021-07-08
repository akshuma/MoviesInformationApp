//
//  DummyJsonProcess.swift
//  MoviesInformationAppTests
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import Foundation
@testable import MoviesInformationApp

class DummyJsonProcess {
    static let shared = DummyJsonProcess()
    private init() {}
    
    func processDummyJsonResponse<T: Codable>(filePath: String?, completionHandler: @escaping(Result<T, TaskError>) -> Void) {
        if let filePath = filePath {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath), options:.mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let jsonObject = try decoder.decode(T.self, from: jsonData)
                    completionHandler(.success(jsonObject, 200))
                } catch  {
                    completionHandler(.failure(.jsonError, 500))
                }
            } catch  {
                
            }
        }
        
    }
}
