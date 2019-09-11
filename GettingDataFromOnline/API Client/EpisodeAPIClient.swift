//
//  EpisodeAPIClient.swift
//  GettingDataFromOnline
//
//  Created by Mr Wonderful on 9/10/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

struct EpisodesPIClient{
    
    static let shared = EpisodesPIClient()
    
    func fetchData(number:Int?,completionHandler: @escaping (Result<[Episode],AppError>) -> ()){
        
        var episodeURL = "http://api.tvmaze.com/shows/200/episodes"
        
        if let episodeID = number {
            episodeURL = "http://api.tvmaze.com/shows/\(episodeID)/episodes"
        }
        
        NetworkManager.shared.fetchData(urlString: episodeURL) { (result) in
            switch result{
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                
                do{
                    let episodeData = try JSONDecoder().decode([Episode].self, from: data)
                    completionHandler(.success(episodeData))
                }catch{
                    completionHandler(.failure(.badDJSONError))
                }
            }
        }
    }
}
