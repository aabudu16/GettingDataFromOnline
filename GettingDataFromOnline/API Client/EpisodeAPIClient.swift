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
    
    func fetchData(unmber:Int?,completionHandler: @escaping (Result<Episode,AppError>) -> ()){
        
        var episodeURL = "http://api.tvmaze.com/shows/45/episodes"
        
        if let episodeID = unmber {
            episodeURL = "http://api.tvmaze.com/search/shows?q=\(episodeID)"
        }
        
        NetworkManager.shared.fetchData(urlString: episodeURL) { (result) in
            switch result{
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                
                do{
                    let episodeData = try JSONDecoder().decode(Episode.self, from: data)
                    completionHandler(.success(episodeData))
                }catch{
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}
