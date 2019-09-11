//
//  SeasonModel.swift
//  GettingDataFromOnline
//
//  Created by Mr Wonderful on 9/10/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit


struct ShowWrapper:Codable{
    let show:Shows
}

struct Shows:Codable{
    let id:Int
    let name:String
    let image:Images?
}

struct Images:Codable {
    let medium:String
    let original:String
}
