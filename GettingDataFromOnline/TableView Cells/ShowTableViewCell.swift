//
//  SeasonsTableViewCell.swift
//  GettingDataFromOnline
//
//  Created by Mr Wonderful on 9/10/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    @IBOutlet var showTitle: UILabel!
    @IBOutlet var showImage: UIImageView!
    @IBOutlet var loadingActivity: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
