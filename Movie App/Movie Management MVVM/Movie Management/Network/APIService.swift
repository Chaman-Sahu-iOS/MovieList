//
//  MobileAPIService.swift
//  Movie Management
//
//  Created by chaman-8419 on 11/12/22.
//

import UIKit

struct Domain {
    static let baseURL = "http://api.themoviedb.org/3/search/movie?api_key=7e588fae3312be4835d4fcf73918a95f&query=a%20&page=01"
    static let imgBaseURL = "http://image.tmdb.org/t/p/w92"
}

class APIService: NSObject, Requestable {
    
    static let instance = APIService()

    public var movies: [Movie]?
    
    func fetchMovies(callback: @escaping Handler) {
        
        request(method: .get, url: Domain.baseURL) { (result) in
            
           callback(result)
        }
        
    }
    
    func fetchImage(imageExtension: String,callback: @escaping Handler) {
        
        request(method: .get, url: Domain.imgBaseURL + imageExtension) { (result) in
            
           callback(result)
        }
        
    }
    
}
