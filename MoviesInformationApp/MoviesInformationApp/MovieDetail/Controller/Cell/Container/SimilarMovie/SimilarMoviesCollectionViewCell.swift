//
//  SimilarMoivesCollectionViewCell.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import UIKit

class SimilarMoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImageView.setCornerRadius()
    }
    
    func setUpCellData(_ similarMovie: SimilarMovie?) {
        movieNameLabel.text = similarMovie?.originalTitle
        if let posterPath = similarMovie?.posterPath {
            let imageUrl = "\(Constant.PosterImageBasePath.path)\(posterPath)"
            movieImageView.loadImage(with: imageUrl)
        } else {
            movieImageView.image = UIImage(named: "profile")
        }
    }

}
