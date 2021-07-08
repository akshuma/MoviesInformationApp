//
//  MoiveListViewDataSource.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit

class MovieListViewDataSource: NSObject, UITableViewDataSource {
    var movieListData: [Movies] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.movieListTableViewCell, for: indexPath)
                as? MovieListTableViewCell else {return UITableViewCell()}
        cell.setUpCellData(movieListData[indexPath.row])
        return cell
    }
    
}
