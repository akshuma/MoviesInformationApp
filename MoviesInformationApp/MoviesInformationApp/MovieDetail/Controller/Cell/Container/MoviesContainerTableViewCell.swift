//
//  SimilarMoiveTableViewCell.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit

protocol ContainerTableViewCellDelegate: class {
    func moveToMovieDetail(_ movieId: Int, movieTitle: String)
}


class MoviesContainerTableViewCell: UITableViewCell {
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var titleHeaderView: UIView!
    //collection view data source
    var dataSource = MoviesContainerDataSource()
    //container identifier
    var containerIdentifier: ContainerIdenifier?
    //container delegate
    weak var delegate: ContainerTableViewCellDelegate?
    //Repository defination
    var similarMovieRepository: SimilarMoviesRepositoryProtocol = SimilarMoviesRepository.shared
    var similarMoviesResponse: SimilarMoviesResponse?
    var castArray: [Cast]?
    var similarMoivesArray: [SimilarMovie]?
    var pageNoForSimilarMovie = 1
    var movieId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        register()
        movieCollectionView.dataSource = dataSource
        movieCollectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func register() {
        //Register cell xib
        movieCollectionView.register(UINib(nibName: "\(SimilarMoviesCollectionViewCell.self)" , bundle: Bundle.main), forCellWithReuseIdentifier: Constant.CellIdentifier.similarMoviesCollectionViewCell)
        movieCollectionView.register(UINib(nibName: "\(CreditsCollectionViewCell.self)" , bundle: Bundle.main), forCellWithReuseIdentifier: Constant.CellIdentifier.creditsCollectionViewCell)
    }
    
    //MARK:- Cell data assignment 
    func setUpCellData<T>(_ cellData: T, title: String?, containerId: ContainerIdenifier) {
        if let cellData = cellData as? CreditsResponse {
            castArray = cellData.cast
            dataSource.castArray = cellData.castAndCrewArray ?? []
            
        } else if let cellData = cellData as? SimilarMoviesResponse {
            similarMoivesArray = cellData.results
            dataSource.similarMovies = cellData.results
            similarMoviesResponse = cellData
        }
        titleHeaderView.backgroundColor = title == nil ? UIColor.clear : UIColor.tertiarySystemFill
        headerTitleLabel.text = title
        dataSource.identifier = containerId
        containerIdentifier = containerId
        movieCollectionView.reloadData()
    }
    
    
}
//MARK:- api call
extension MoviesContainerTableViewCell {
    
    fileprivate func getSimilarMovie(movieId: Int?, pageNo: Int) {
        guard let id = movieId else {return }
        similarMovieRepository.getSimilarMoives(moiveId: String(id), pageNo: pageNo) { [weak self] (result) in
            guard let weakSelf = self else {return}
            switch result {
            case .success(let similarMoviesResponse, _):
                weakSelf.similarMoviesResponse = similarMoviesResponse
                weakSelf.dataSource.similarMovies = similarMoviesResponse.results
                weakSelf.reloadCollectionView(similarMovieResponse: similarMoviesResponse)
            case .failure:
                break
            }
        }
    }
    
    fileprivate func reloadCollectionView(similarMovieResponse: SimilarMoviesResponse?) {
        dataSource.similarMovies.append(contentsOf: similarMovieResponse?.results ?? [])
        let indexPaths = (0 ..< dataSource.similarMovies.count).map { IndexPath(row: $0, section: 0) }
        movieCollectionView.performBatchUpdates ({
            movieCollectionView.insertItems(at: indexPaths)
        } ,completion: nil)
    }
    
}
//MARK: - UICollectionViewDelegateFlowLayout
extension MoviesContainerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch containerIdentifier {
        case .similarMovie:
            return CGSize(width: 160, height: 240)
        default:
            return CGSize(width: 160, height: 180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
//MARK: - UICollectionViewDelegate
extension MoviesContainerTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch containerIdentifier {
        case .similarMovie:
            if dataSource.similarMovies.count == indexPath.row + 1 && (similarMoviesResponse?.totalPages ?? 0) > pageNoForSimilarMovie {
                pageNoForSimilarMovie += 1
                getSimilarMovie(movieId: movieId, pageNo: pageNoForSimilarMovie)
            }
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch containerIdentifier {
        case .similarMovie:
            delegate?.moveToMovieDetail(dataSource.similarMovies[indexPath.row].id ?? 0, movieTitle: dataSource.similarMovies[indexPath.row].originalTitle ?? String.blank)
        default:
            break
        }
    }
}
