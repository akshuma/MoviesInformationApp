//
//  MoviesApi.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 02/07/21.
//

import UIKit

protocol URLComponentsRepresentable {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? {get}
}

extension URLComponentsRepresentable {
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents
    }
    
    var url: URL? {
        return urlComponents.url
    }
}
enum MoviesApis {
    case moiveList(pageNo: Int)
    case synoypsisData(movieId: String)
    case usersReviews(movieId: String, pageNo: Int)
    case credits(movieId: String)
    case similarMovies(movieId: String, pageNo: Int)
    
}

extension MoviesApis :URLComponentsRepresentable{
    var scheme: String {
        "https"
    }
    
    var host: String {
        Environment.serverEndPoint
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .moiveList(let pageNo):
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: "api_key", value: Environment.apiKey))
            queryParam.append(URLQueryItem(name: "page", value: String(pageNo)))
            return queryParam
        case .synoypsisData(_):
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: "api_key", value: Environment.apiKey))
            return queryParam
            
        case .usersReviews(_, let pageNo):
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: "api_key", value: Environment.apiKey))
            queryParam.append(URLQueryItem(name: "page", value: String(pageNo)))
            return queryParam
            
        case .credits(_):
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: "api_key", value: Environment.apiKey))
            return queryParam
            
        case .similarMovies(_, let pageNo):
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: "api_key", value: Environment.apiKey))
            queryParam.append(URLQueryItem(name: "page", value: String(pageNo)))
            return queryParam
        }
    }
    
    
    var path: String {
        let basePath = "/\(Environment.apiVersion)"
        switch self {
        case .moiveList(_):
            return "\(basePath)/movie/now_playing"
        case .synoypsisData(let movieId):
            return "\(basePath)/movie/\(movieId)"
        case .usersReviews(let movieId, _):
            return "\(basePath)/movie/\(movieId)/reviews"
        case .credits(let movieId):
            return "\(basePath)/movie/\(movieId)/credits"
        case .similarMovies(let movieId, _):
            return "\(basePath)/movie/\(movieId)/similar"
        }
    }
    
    
    
    
}
