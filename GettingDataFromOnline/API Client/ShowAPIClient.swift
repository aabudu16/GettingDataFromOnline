//
//  SeasonsAPIClient.swift
//  GettingDataFromOnline
//
//  Created by Mr Wonderful on 9/10/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

struct ShowAPIClient{
    
    static let shared = ShowAPIClient()
    
    let isFetching = false
    
    func fetchData(movieTitle:String?,completionHandler: @escaping (Result<[ShowWrapper],AppError>) -> ()){
        
        var showURL = "http://api.tvmaze.com/search/shows?q=girls"
        
        if let show = movieTitle {
            let newString = show.replacingOccurrences(of: " ", with: "-")
            
            showURL = "http://api.tvmaze.com/search/shows?q=\(newString)"
        }
        
        NetworkManager.shared.fetchData(urlString: showURL) { (result) in
            switch result{
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                
                do{
                    let showData = try JSONDecoder().decode([ShowWrapper].self, from: data)
                    completionHandler(.success(showData))
                }catch{
                    completionHandler(.failure(.badDJSONError))
                    print(error)
                }
            }
        }
    }
}
