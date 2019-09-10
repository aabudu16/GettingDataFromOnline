//
//  EpisodeModel.swift
//  GettingDataFromOnline
//
//  Created by Mr Wonderful on 9/10/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

struct Episode:Codable{
    let id:Int
    let name:String
    let season:Int
    let number:Int
    let image:EpisodeImages
    let summary:String
    
}

struct EpisodeImages:Codable{
    let medium:String
    let original:String
}
