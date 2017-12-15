//
//  CriticsAndMoviesViewController.swift
//  2017_12_11 collectionView Exercise critics
//
//  Created by C4Q on 12/14/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class CriticsAndMoviesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var criticsTableView: UITableView!
    @IBOutlet weak var CriticedMoviesCollectionView: UICollectionView!
    var critics = [Critic](){
        didSet{
            criticsTableView.reloadData()
        }
    }
    var criticReviews = [Review](){
        didSet{
            CriticedMoviesCollectionView.reloadData()
        }
    }
    var searchTerm = ""{
        didSet{
            loadReviews()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return critics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let criticSetup = critics[indexPath.row]
        guard let cell: UITableViewCell = criticsTableView.dequeueReusableCell(withIdentifier: "creticsCell") else {
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = criticSetup.displayName
            return defaultCell
        }
        cell.textLabel?.text = criticSetup.displayName.capitalized
        cell.detailTextLabel?.text = criticSetup.status?.capitalized ?? "Unavailable"
        return cell
    }
    
    
    func loadCritics(){
//        let mycompletion: ([Critic])->Void = {(criticsfromOnline: [Critic])in
//            self.critics = criticsfromOnline
//        }
//        let appError: (AppError)->Void = {(onlineAppError: Error) in
//            print(onlineAppError)
//        }

        CriticAPIClient.manager.getCritics(for: "", completionHandler: {self.critics = $0}, errorHandler: {print($0)})
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let criticSetup = critics[indexPath.row]
        searchTerm = criticSetup.displayName
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.criticsTableView.delegate = self
        self.criticsTableView.dataSource = self
        self.CriticedMoviesCollectionView.dataSource = self
        self.CriticedMoviesCollectionView.delegate = self
        loadCritics()
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CriticsAndMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return criticReviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reviewSetup = criticReviews[indexPath.row]
        let cell:UICollectionViewCell = CriticedMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath)
        if let cell = cell as? ReviewCellCollectionViewCell{
            cell.displayTitle.text = reviewSetup.displayTitle
            cell.summaryShort.text = reviewSetup.summaryShort
        }
        
        return cell
    }
    
    func loadReviews(){
        ReviewAPIClient.manager.getReviews(for: searchTerm, completionHandler: {self.criticReviews = $0}, errorHandler: {print($0)})
        
    }
    
    
}



