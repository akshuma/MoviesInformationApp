//
//  CustomerReviewDataSource.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit

class UserReviewDataSource: NSObject, UITableViewDataSource {
    var usersReview: [Reviews] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.userReviewTableViewCell) as? UserReviewTableViewCell else {return UITableViewCell()}
        cell.setUpCellData(usersReview[indexPath.row])
        return cell
    }
    

}
