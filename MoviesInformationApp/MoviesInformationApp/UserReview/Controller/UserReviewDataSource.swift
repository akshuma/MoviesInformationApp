//
//  CustomerReviewDataSource.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit

class UserReviewDataSource: NSObject, UITableViewDataSource {
    var usersReview: [Reviews] = []
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if usersReview.count > 0 {
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No Reviews Available"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = NSTextAlignment.center
            tableView.backgroundView = noDataLabel
            
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return fetchUserReviews(tableView, indexPath: indexPath)
    }
    
}
extension UserReviewDataSource {
    fileprivate func fetchUserReviews(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.userReviewTableViewCell) as? UserReviewTableViewCell else {return UITableViewCell()}
        cell.setUpCellData(usersReview[indexPath.row])
        return cell
    }
    
}
