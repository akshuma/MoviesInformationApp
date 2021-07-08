//
//  MovieSynoypsisTableViewCell.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit
import Cosmos

class MovieSynoypsisTableViewCell: UITableViewCell {
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var overViewlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        moviePosterImageView.setCornerRadius()
        bgView.makeCorner(withRadius: 10)
        ratingView.settings.updateOnTouch = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // cell data assignment
    func setUpCellData(_ movie: SynoypsisResponse?) {
        movieNameLabel.text = movie?.originalTitle
        movieReleaseDate.text = String.convertDateToStringUsingTimeStamp((movie?.releaseDate ?? String.blank), dateFormat: DateFormat.movieListing.rawValue)
        if let posterPath = movie?.posterPath {
            let imageUrl = "\(Constant.PosterImageBasePath.path)\(posterPath)"
            moviePosterImageView.loadImage(with: imageUrl)
        } else {
            moviePosterImageView.image = UIImage(named: "profile")
        }
        ratingView.rating = movie?.voteAverage ?? 0.0
        overViewlabel.text = movie?.overview
    }
}
