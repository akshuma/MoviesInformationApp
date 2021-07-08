//
//  MovieDetailViewController.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieDetailTableView: UITableView!
    //Table view data source
    var dataSource = MovieDetailViewDataSource()
    //Repository assignment
    var synoypsisRepository: SynoypsisRepositoryProtocol = SynoypsisRepository.shared
    var movieCreditsRepository: CreditsRepositoryProtocol = CreditsRepository.shared
    var similarMovieRepository: SimilarMoviesRepositoryProtocol = SimilarMoviesRepository.shared
    
    var movieId: Int?
    var movieTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        setup()
        getSysnoypsisData(movieId: movieId)
        getMovieCreditsData(movieId: movieId)
        getSimilarMovie(movieId: movieId)
        
    }
    
    fileprivate func setup() {
        self.title = self.movieTitle
        setCustomNavigation()
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = dataSource
        dataSource.movieId = movieId
        dataSource.delegate = self
    }
    
    fileprivate func register() {
        //Register cell xib
        movieDetailTableView.register(UINib(nibName: "\(MovieSynoypsisTableViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: Constant.CellIdentifier.movieSynoypsisTableViewCell)
        movieDetailTableView.register(UINib(nibName: "\(UserReviewHeaderTableViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: Constant.CellIdentifier.userReviewHeaderTableViewCell)
        movieDetailTableView.register(UINib(nibName: "\(MoviesContainerTableViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: Constant.CellIdentifier.moviesContainerTableViewCell)
    }
    
}
//MARK:- API call
extension MovieDetailViewController {
    // Synoypsis api call
    fileprivate func getSysnoypsisData(movieId: Int?) {
        guard let id = movieId else {return }
        startActivityIndicator()
        synoypsisRepository.getSynoypsis(movieId: String(id)) { [weak self] (result) in
            guard let weakSelf = self else {return}
            weakSelf.stopActivityIndicator()
            switch result {
            case .success(let synoypsisResponse, _):
                weakSelf.dataSource.synoypsisResponse = synoypsisResponse
                weakSelf.movieDetailTableView.reloadSections(IndexSet([0]), with: .none)
            case .failure:
                break
            }
        }
    }
    
    // credits api call
    fileprivate func getMovieCreditsData(movieId: Int?) {
        guard let id = movieId else {return }
        startActivityIndicator()
        movieCreditsRepository.getCredits(movieId: String(id)) { [weak self] (result) in
            guard let weakSelf = self else {return}
            weakSelf.stopActivityIndicator()
            switch result {
            case .success(let movieCreditsResponse, _):
                weakSelf.dataSource.castResponse = movieCreditsResponse
                weakSelf.movieDetailTableView.reloadSections(IndexSet([1]), with: .none)
            case .failure:
                break
            }
        }
    }
    // similar api call
    fileprivate func getSimilarMovie(movieId: Int?) {
        guard let id = movieId else {return }
        startActivityIndicator()
        similarMovieRepository.getSimilarMoives(moiveId: String(id), pageNo: 1) { [weak self] (result) in
            guard let weakSelf = self else {return}
            weakSelf.stopActivityIndicator()
            switch result {
            case .success(let similarMoviesResponse, _):
                weakSelf.dataSource.similarMovies = similarMoviesResponse
                weakSelf.movieDetailTableView.reloadSections(IndexSet([3]), with: .none)
            case .failure:
                break
            }
        }
    }
    
}
//MARK:- UITableViewDelegate
extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            moveToUserReview(movieId)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return (dataSource.castResponse?.castAndCrewArray?.count ?? 0) > 0 ? 200 : 0.0
        case 3:
            return (dataSource.castResponse?.castAndCrewArray?.count ?? 0) > 0 ? 300 : 0.0 
        default:
            return UITableView.automaticDimension
        }
    }
    
    func moveToUserReview(_ movieId: Int?) {
        let storyBoard = UIStoryboard(name: Constant.StoryBoardName.userReview, bundle: nil)
        guard
            let vc = storyBoard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.userReviewViewController) as? UserReviewViewController else {return}
        vc.movieId = movieId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK:- MovieDetailViewDataSource Delegate
extension MovieDetailViewController: MovieDetailViewDataSourceDelegate {
    func moveToSimilarMovieDetailPage(_ movieId: Int, movieTitle: String) {
        let storyBoard = UIStoryboard(name: Constant.StoryBoardName.movieDetail, bundle: nil)
        guard
            let vc = storyBoard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.movieDetailViewController) as? MovieDetailViewController else {return}
        vc.movieId = movieId
        vc.movieTitle = movieTitle
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
