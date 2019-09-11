//
//  EpisodeViewController.swift
//  GettingDataFromOnline
//
//  Created by Mr Wonderful on 9/10/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    @IBOutlet var episodeTableView: UITableView!
    var shows:ShowWrapper?
    var episodes = [Episode](){
        didSet{
            DispatchQueue.main.async {
                self.episodeTableView.reloadData()
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
    }
    
    
 private func setupView(){
    episodeTableView.delegate = self
    episodeTableView.dataSource = self
    }
    func fetchData(number:Int?){
        EpisodesPIClient.shared.fetchData(number: number) { (result) in
            switch result{
            case .failure(let error):
                print("cant retrieve episodes \(error)")
            case .success(let episodes):
                DispatchQueue.main.async {
                    self.episodes = episodes
                }
            }
        }
    }
    func loadData(){
        if let show = shows?.show.id{
          fetchData(number: show)
        }
        
    }
}


extension EpisodeViewController: UITableViewDelegate{}
extension EpisodeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell") as? EpisodeTableViewCell else {return UITableViewCell()}
        
        let info = episodes[indexPath.row]
        cell.episodeTitle.text = info.name
        cell.seasonAndEpisodeNumber.text = info.episode
        
        if let episodeImage = info.image{
            ImageHelper.shared.fetchImage(urlImage: episodeImage.medium) { (result) in
                switch result{
                case .failure(let error):
                    print("cant fetch Image \(error)")
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.activityIndicator.stopAnimating()
                        cell.episodeImage.image = image
                    }
                    
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let EpisodeDVC = storyboard?.instantiateViewController(withIdentifier: "EpisodeDVC") as? EpisodeDetailedViewController else {return}
        
        let info = episodes[indexPath.row]
        
        EpisodeDVC.episode = info
        
        self.navigationController?.pushViewController(EpisodeDVC, animated: true)
    }
}
