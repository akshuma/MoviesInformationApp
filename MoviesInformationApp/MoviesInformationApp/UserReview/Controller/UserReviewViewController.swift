//
//  CustomerReviewViewController.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit

class UserReviewViewController: UIViewController {
    @IBOutlet weak var userReviewTableView: UITableView!
    //TableView dataSource
    var dataSource = UserReviewDataSource()
    //repository defination
    var useReviewsRepository: UsersReviewsRepositoryProtocol = UsersReviewsRepository.shared
    var movieId: Int?
    var userReviewResponse: UsersReviewsResponse?
    var pageNo = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        setup()
        getUserReviewsData(movieId: movieId, pageNo: pageNo)
    }
    
    fileprivate func setup() {
        self.title = "Movie Review"
        userReviewTableView.tableFooterView = UIView()
        setCustomNavigation()
        userReviewTableView.delegate = self
        userReviewTableView.dataSource = dataSource
    }
    
    fileprivate func register() {
        //Register cell xib
        userReviewTableView.register(UINib(nibName: "\(UserReviewTableViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: Constant.CellIdentifier.userReviewTableViewCell)
        userReviewTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
//MARK:- API call
extension UserReviewViewController {

    fileprivate func getUserReviewsData(movieId: Int?, pageNo: Int) {
        guard let id = movieId else {return }
        startActivityIndicator()
        useReviewsRepository.getCustomerReviews(moiveId: String(id), pageNo: pageNo) { [weak self] (result) in
            guard let weakSelf = self else {return}
            weakSelf.stopActivityIndicator()
            switch result {
            case .success(let userReviewResponse, _):
                weakSelf.userReviewResponse = userReviewResponse
                weakSelf.reloadtableViewWithData(userReviewResponse.results ?? [])
            case .failure:
                break
            }
        }
    }
    
    func reloadtableViewWithData( _ reviews: [Reviews])  {
        dataSource.usersReview.append(contentsOf: reviews)
        let indexPaths = (0 ..< dataSource.usersReview.count).map {IndexPath(row: $0, section: 0)}
        userReviewTableView.beginUpdates()
        userReviewTableView.insertRows(at: indexPaths, with: .none)
        userReviewTableView.endUpdates()
    }
    
}
//MARK:- UITableViewDelegate
extension UserReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if dataSource.usersReview.count == indexPath.row + 1 && (userReviewResponse?.totalPages ?? 0) > pageNo {
            pageNo += 1
            getUserReviewsData(movieId: movieId, pageNo: pageNo)
        }
    }
    
}
