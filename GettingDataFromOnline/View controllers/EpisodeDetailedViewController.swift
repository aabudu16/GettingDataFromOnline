//
//  EpisodeDetailedViewController.swift
//  GettingDataFromOnline
//
//  Created by Mr Wonderful on 9/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class EpisodeDetailedViewController: UIViewController {

    var episode:Episode!
    
    @IBOutlet var episodeImage: UIImageView!
    @IBOutlet var episodeName: UILabel!
    @IBOutlet var episodeSeason: UILabel!
    @IBOutlet var episodeNumber: UILabel!
    
    @IBOutlet var episodeDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupView()
    }
    
  private func setupView(){
    
    
    episodeName.text = episode.name
    episodeSeason.text = "Season \(episode.season)"
    episodeNumber.text = "Episode \(episode.number)"
    episodeDescription.text = episode.summary
    
    if let ImageString = episode.image{
    ImageHelper.shared.fetchImage(urlImage: ImageString.original) { (result) in
        switch result{
        case .failure(let error):
            print("no image \(error)")
        case .success(let image):
            DispatchQueue.main.async {
                  self.episodeImage.image = image
            }
        }
    }
    }
    }
}
