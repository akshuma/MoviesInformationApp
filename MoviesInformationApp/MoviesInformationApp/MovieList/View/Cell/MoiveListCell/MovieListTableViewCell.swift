//
//  MoiveListTableViewCell.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit
import Cosmos

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieBookButton: UIButton!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setUpUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpUI() {
        moviePosterImageView.setCornerRadius()
        movieBookButton.setCornerRadius()
        bgView.makeCorner(withRadius: 10)
        ratingView.settings.updateOnTouch = false
    }
    
    // MARK: - Assign data to celll
    func setUpCellData(_ movie: Movies?) {
        movieNameLabel.text = movie?.title
        movieReleaseDate.text = String.convertDateToStringUsingTimeStamp((movie?.releaseDate ?? String.blank), dateFormat: DateFormat.movieListing.rawValue)
        if let posterPath = movie?.posterPath {
            let imageUrl = "\(Constant.PosterImageBasePath.path)\(posterPath)"
            moviePosterImageView.loadImage(with: imageUrl)
        } else {
            moviePosterImageView.image = UIImage(named: "profile")
        }
        ratingView.rating = movie?.voteAverage ?? 0.0
        
    }
    
    override func prepareForReuse() {
        movieNameLabel.text = nil
        movieReleaseDate.text = nil
        moviePosterImageView.image = nil
        ratingView.rating = 0.0
        super.prepareForReuse()
    }
}
