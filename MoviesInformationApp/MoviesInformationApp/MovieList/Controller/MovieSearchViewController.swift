//
//  MovieSearchViewController.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 05/07/21.
//

import UIKit
import CoreData

class MovieSearchViewController: UITableViewController {

    var movieSearchRepository: MovieSearchRepositoryProtocol = MovieSearchRepository.shared
    var moviesArray: [Movies]?
    
//    lazy var recentSearchResultsController: NSFetchedResultsController<Search> = {
//        let fetchRequest: NSFetchRequest<Search> = Search.fetchRequest()
//        fetchRequest.fetchLimit = 5
//        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
//        //fetchRequest.sortDescriptors = [sortDescriptor]
//        let recentSearchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: nil, cacheName: nil)
//        return recentSearchController
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        setUp()
    }

    fileprivate func register() {
        //Cell Register
        tableView.register(UINib(nibName: "\(RecentSearchTableViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: Constant.CellIdentifier.recentSearchTableViewCell)
        tableView.register(UINib(nibName: "\(SearchTableViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: Constant.CellIdentifier.searchTableViewCell)
    }
    
    fileprivate func setUp() {
        tableView.tableFooterView = UIView()
        setUpSearchBar()
        setUpSearchResultViewController()
    }
    
   fileprivate func setUpSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    func setUpSearchResultViewController()  {
//        do {
//            try recentSearchResultsController.performFetch()
//            recentSearchResultsController.delegate = self
//        } catch  {
//            fatalError(error.localizedDescription)
//        }
    }
    
    fileprivate func fetchRecentSearchCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RecentSearchTableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.recentSearchTableViewCell, for: indexPath) as? RecentSearchTableViewCell else {return RecentSearchTableViewCell()}
       // cell.recentSearchLabel.text = recentSearchResultsController.object(at: IndexPath(row: indexPath.row, section: 0)).movieName
        return cell
    }
    
    fileprivate func fetchSearchCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> SearchTableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.searchTableViewCell, for: indexPath) as? SearchTableViewCell else {return SearchTableViewCell()}
        cell.searchLabel.text = moviesArray?[indexPath.row].title ?? ""
        return cell
    }
}

extension MovieSearchViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 2
        default:
           return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            return fetchSearchCell(tableView, cellForRowAt: indexPath)
        case 2:
            return fetchRecentSearchCell(tableView, cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
}
extension MovieSearchViewController {
    //MARK:- API cell
    // Mark: - Api call
    func getSearchMovies(query: String, pageNo: Int) {
        self.startActivityIndicator()
        movieSearchRepository.getSearchMovies(query: query, pageNo: 1) {[weak self] (response) in
            guard let weakSelf = self else {return}
            weakSelf.stopActivityIndicator()
            switch response {
            case .success(let movieList, _):
                weakSelf.moviesArray = movieList.results
                weakSelf.tableView.reloadData()
            case .failure:
                break
            }
        }
     }
}

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            if text.isEmpty == false {
                getSearchMovies(query: text, pageNo: 1)
            }
        }
    }
    
    
}
extension MovieSearchViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
}
