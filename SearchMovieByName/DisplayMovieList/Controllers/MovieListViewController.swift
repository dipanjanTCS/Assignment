//
//  MovieListViewController.swift
//  SearchMovieByName
//
//  Created by Dipanjan Sarker on 11/05/20.
//  Copyright © 2020 Dipanjan Sarker. All rights reserved.
//

import UIKit
import SwiftUI

class MovieListViewController: UITableViewController {
    
    @IBOutlet weak var movieNameSearchBar: UISearchBar!
    var searchMovieListPresenter : SearchMovieListPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.searchMovieListPresenter == nil{
            let searchMovieNameValidator = SearchMovieNameValidator()
            let searchMovieNameWebService = SearchMovieNameWebService()
            searchMovieListPresenter = SearchMovieListPresenter(fromMovieNameValidator: searchMovieNameValidator, webService: searchMovieNameWebService, delegate: self)
        }
        self.tableView.tableFooterView = UIView()
    }
    
    @IBSegueAction func goToMovieDetails(_ coder: NSCoder, sender: Any?) -> UIViewController? {
        
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else{
            fatalError("TableView is not selected")
        }
        
        let movieDetailsView = MovieDetailsView(selectedMovieDetailModel: searchMovieListPresenter!.selectedMovieDetails(for: selectedIndexPath.row))
        return UIHostingController(coder: coder, rootView: movieDetailsView)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let searchMovieListPresenter = self.searchMovieListPresenter else {
            return 0
        }
        return searchMovieListPresenter.rownumbers()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let searchMovieListPresenter = self.searchMovieListPresenter else {
            return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        }
        return searchMovieListPresenter.prepareCell(for: tableView, cellForRowAt: indexPath)
        
    }
    
    
    
    
}

extension MovieListViewController : UISearchBarDelegate,SearchMovieNameViewDelegateProtocol{
    //MARK:- SearchMovieNameViewDelegateProtocol Methods
    
    func successfulyFetchedMovieList() {
        self.tableView.reloadData()
        
    }
    
    func errorHandler(with error: SearchMovieErrors) {
        
        let alert = UIAlertController(title: "Alert", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK:- UISearchBarDelegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.movieNameSearchBar.endEditing(true)
        self.searchMovieListPresenter?.processSearchedMovieName(with: searchBar.text ?? "")
        
    }
    
    
    
}
