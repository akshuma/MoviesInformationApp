//
//  MovieDetailViewDataSource.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit
protocol MovieDetailViewDataSourceDelegate: class {
    func moveToSimilarMovieDetailPage(_ movieId: Int, movieTitle: String)
}

class MovieDetailViewDataSource: NSObject, UITableViewDataSource {
    var synoypsisResponse: SynoypsisResponse?
    var castResponse: CreditsResponse?
    var similarMovies: SimilarMoviesResponse?
    var movieId: Int?
    weak var delegate: MovieDetailViewDataSourceDelegate?
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        /*
         - sectiom 0 :- synoypsis
         - sectiom 1 :- cast
         - sectiom 2 :- user review
         - sectiom 3 :- similar movies
         */
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return fetchMovieSynoypsis(tableView, indexPath: indexPath)
        case 1:
            return fetchMovieCast(tableView, indexPath: indexPath)
        case 2:
            return fetchUserReviews(tableView, indexPath: indexPath)
        case 3:
            return fetchSimilarMovies(tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    

}

extension MovieDetailViewDataSource {
    
    fileprivate func fetchMovieSynoypsis(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.movieSynoypsisTableViewCell, for: indexPath) as? MovieSynoypsisTableViewCell else {return MovieSynoypsisTableViewCell()}
        cell.setUpCellData(synoypsisResponse)
        return cell
    }
    
    fileprivate func fetchMovieCast(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.moviesContainerTableViewCell, for: indexPath) as? MoviesContainerTableViewCell else {return MoviesContainerTableViewCell()}
        let title = (castResponse?.cast?.count ?? 0) > 0 ? "Cast & Crew" : ""
        cell.movieId = movieId
        cell.setUpCellData(castResponse, title: title, containerId: .cast)
        return cell
    }
    
    fileprivate func fetchSimilarMovies(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.moviesContainerTableViewCell, for: indexPath) as? MoviesContainerTableViewCell else {return MoviesContainerTableViewCell()}
        cell.movieId = movieId
        let title = (similarMovies?.results.count ?? 0) > 0 ? "You might also like" : ""
        cell.delegate = self
        cell.setUpCellData(similarMovies, title: title, containerId: .similarMovie)
        return cell
    }
    
    fileprivate func fetchUserReviews(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.userReviewHeaderTableViewCell, for: indexPath) as? UserReviewHeaderTableViewCell else {return UserReviewHeaderTableViewCell()}
        return cell
    }
    
}
extension MovieDetailViewDataSource: ContainerTableViewCellDelegate {
    func moveToMovieDetail(_ movieId: Int, movieTitle: String) {
        delegate?.moveToSimilarMovieDetailPage(movieId, movieTitle: movieTitle)
    }
    
}
