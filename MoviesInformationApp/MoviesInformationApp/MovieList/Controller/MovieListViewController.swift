//
//  MovieListViewController.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 02/07/21.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    //Table view data source
    var dataSource = MovieListViewDataSource()
    //Repository assignment
    var movieListingRepository: MovieListingRepositoryProtocol = MovieListingRepository.shared
    var pageNo: Int = 1
    var movieListResponse: MovieListResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        register()
        getPlayingMovies(pageNo: pageNo)
    }
    
    fileprivate func setup() {
        self.title = "Movie List"
        setCustomNavigation(isLeftBarButton: false)
        movieTableView.delegate = self
        movieTableView.dataSource = dataSource
    }
    
    fileprivate func register() {
        //Register cell xib
        movieTableView.register(UINib(nibName: "\(MovieListTableViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: Constant.CellIdentifier.movieListTableViewCell)
    }
    
}
// MARK: - Api call
extension MovieListViewController {
    
    func getPlayingMovies(pageNo: Int) {
        self.pageNo = pageNo
        self.stopActivityIndicator()
        movieListingRepository.getNowPlayingMovies(pageNo: pageNo) {[weak self] (response) in
            guard let weakSelf = self else {return}
            weakSelf.stopActivityIndicator()
            switch response {
            case .success(let movieList, _):
                weakSelf.movieListResponse = movieList
                weakSelf.loadMovieListData(moviesListResponse: movieList.results)
            case .failure:
                break
            }
        }
    }
    
    func loadMovieListData(moviesListResponse: [Movies]?) {
        dataSource.movieListData.append(contentsOf: moviesListResponse ?? [])
        movieTableView.reloadSections(IndexSet.init(integer: 0), with: .none)
        
    }
    
    func pushToDetailView(movieId: Int, movieTitle: String)  {
        let storyBoard = UIStoryboard(name: Constant.StoryBoardName.movieDetail, bundle: nil)
        guard
            let vc = storyBoard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.movieDetailViewController) as? MovieDetailViewController else {return}
        vc.movieId = movieId
        vc.movieTitle = movieTitle
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if dataSource.movieListData.count == indexPath.row + 1 && (movieListResponse?.totalPages ?? 0) > pageNo {
            pageNo += 1
            getPlayingMovies(pageNo: pageNo)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = dataSource.movieListData[indexPath.row]
        pushToDetailView(movieId:Int(movie.id ?? 0), movieTitle: movie.title ?? String.blank)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
// MARK: - push to search view
extension MovieListViewController {
    @IBAction func movieSearchClick(_ sender: Any) {
        let storyBoard = UIStoryboard(name: Constant.StoryBoardName.movieList, bundle: nil)
        guard
            let vc = storyBoard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.movieSearchViewController) as? MovieSearchViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
