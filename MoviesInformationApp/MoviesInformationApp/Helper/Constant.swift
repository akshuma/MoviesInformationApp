//
//  Constant.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 02/07/21.
//

import UIKit

struct Constant {
    
    //Constant ScreenSize
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    //Constant StoryBoardName as a StoryBoardIdentifiler
    struct StoryBoardName {
        static let movieList = "MovieList"
        static let movieDetail = "MovieDetail"
        static let userReview = "UserReview"
    }
    
    struct ViewControllerIdentifier {
        static let movieListViewController = "movieListViewController"
        static let movieDetailViewController = "movieDetailViewController"
        static let userReviewViewController = "UserReviewViewController"
        static let movieSearchViewController = "MovieSearchViewController"
    }
    
    struct CellIdentifier {
        static let movieListTableViewCell = "MovieListTableViewCell"
        static let movieSynoypsisTableViewCell = "MovieSynoypsisTableViewCell"
        static let userReviewTableViewCell = "UserReviewTableViewCell"
        static let moviesContainerTableViewCell = "MoviesContainerTableViewCell"
        static let userReviewHeaderTableViewCell = "UserReviewHeaderTableViewCell"
        static let similarMoviesCollectionViewCell = "SimilarMoviesCollectionViewCell"
        static let creditsCollectionViewCell = "CreditsCollectionViewCell"
        static let recentSearchTableViewCell = "RecentSearchTableViewCell"
        static let searchTableViewCell = "SearchTableViewCell"
        
    }
    
    //basePath for images
    struct PosterImageBasePath {
        static let path = "https://image.tmdb.org/t/p/w500"
    }
    

}
