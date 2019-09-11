//
//  ViewController.swift
//  GettingDataFromOnline
//
//  Created by Mr Wonderful on 9/10/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    
    var shows = [ShowWrapper]() {
        didSet {
            DispatchQueue.main.async {
                self.showTableView.reloadData()
            }
        }
    }
    
    @IBOutlet var showTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    private func setupView(){
        showTableView.delegate = self
        showTableView.dataSource = self
        searchBar.delegate = self
        navigationItem.title = "Shows"
    }
    
    var userSearchString:String? = nil{
        didSet{
            self.showTableView.reloadData()
        }
    }
    
    var userFilteredSearch:[ShowWrapper]? {
            return shows
    }
    
    
    func fetchShowData(show:String?){
        ShowAPIClient.shared.fetchData(movieTitle: show) { (result) in
            switch result{
            case .failure(let error):
                print("cant retieve show \(error)")
            case .success(let shows):
                self.shows = shows
            }
        }
    }
}



extension ShowViewController: UITableViewDelegate{}
extension ShowViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userFilteredSearch?.count ?? shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTableViewCell") as? ShowTableViewCell else {return UITableViewCell()}
        let info = userFilteredSearch?[indexPath.row]
        
        cell.showTitle.text = info?.show.name
        
        if let newImage = info?.show.image{
            ImageHelper.shared.fetchImage(urlImage: newImage.original) { (result) in
                switch result{
                case .failure(let error):
                    print("cant get image \(error)")
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.loadingActivity.stopAnimating()
                        cell.showImage.image = image
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let epidsodeDVC = storyboard?.instantiateViewController(withIdentifier: "EpisodeViewController") as? EpisodeViewController else {return}
        
        let info = userFilteredSearch?[indexPath.row]
        
        epidsodeDVC.shows = info
        
        self.navigationController?.pushViewController(epidsodeDVC, animated: true)
    }
}

extension ShowViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.userSearchString = searchBar.text
        fetchShowData(show: searchBar.text)
    }
}
