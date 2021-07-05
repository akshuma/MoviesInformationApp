//
//  CreditsCollectionViewCell.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 04/07/21.
//

import UIKit

class CreditsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castImageView.makeCorner(withRadius: castImageView.frame.height/2)
    }
    
    func setCreditsCellData(_ castData: Cast?) {
        castNameLabel.text = castData?.name
        if let profilePath = castData?.profilePath {
            let imageUrl = "\(Constant.PosterImageBasePath.path)\(profilePath)"
            castImageView.loadImage(with: imageUrl)
        } else {
            castImageView.image = UIImage(named: "profile")
        }
    }

}
