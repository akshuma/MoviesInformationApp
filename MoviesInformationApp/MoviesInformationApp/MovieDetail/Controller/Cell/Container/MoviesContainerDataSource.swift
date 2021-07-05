//
//  MoviesContainerDataSource.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import UIKit

class MoviesContainerDataSource: NSObject, UICollectionViewDataSource {
    var castArray: [Cast] = []
    var similarMovies: [SimilarMovie] = []
    var identifier: ContainerIdenifier?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       let containerIdentifier = identifier
        switch containerIdentifier {
        case .similarMovie:
            return similarMovies.count
        case .cast:
            return castArray.count
        default:
           return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let containerIdentifier = identifier
         switch containerIdentifier {
         case .similarMovie:
             return fetchSimilarMovieCell(collectionView, indexPath: indexPath)
         case .cast:
            return fetchCastMovieCell(collectionView, indexPath: indexPath)
         default:
             return UICollectionViewCell()
         }
    }
    

}

extension MoviesContainerDataSource {
    fileprivate func fetchSimilarMovieCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.similarMoviesCollectionViewCell, for: indexPath) as? SimilarMoviesCollectionViewCell  else {return SimilarMoviesCollectionViewCell()}
        cell.setUpCellData(similarMovies[indexPath.row])
        return cell
    }
    
    fileprivate func fetchCastMovieCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CellIdentifier.creditsCollectionViewCell, for: indexPath) as? CreditsCollectionViewCell  else {return CreditsCollectionViewCell()}
        cell.setCreditsCellData(castArray[indexPath.row])
        return cell
    }
    
}
enum ContainerIdenifier: String {
    case similarMovie
    case cast
}
