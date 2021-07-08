//
//  CustomerReviewTableViewCell.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit
import Cosmos

class UserReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        ratingView.settings.updateOnTouch = false
        authorImageView.makeCorner(withRadius: authorImageView.frame.height/2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //cell data assignment
    func setUpCellData(_ userReview: Reviews?) {
        authorNameLabel.text = userReview?.author ?? String.blank
        ratingView.rating = Double(userReview?.authorDetails?.rating ?? 0)
        dateLabel.text = "@\(userReview?.authorDetails?.username ?? String.blank) \n\(String.convertDateToStringUsingTimeStamp(userReview?.createdAt ?? String.blank, dateFormat: DateFormat.userReview.rawValue))"
        contentLabel.text = userReview?.content ?? String.blank
        if let profilePath = userReview?.authorDetails?.avatarPath {
            let imageUrl = "\(Constant.PosterImageBasePath.path)\(profilePath)"
            authorImageView.loadImage(with: imageUrl)
        } else {
            authorImageView.image = UIImage(named: "profile")
        }
    }
    
}
