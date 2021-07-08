//
//  UIViewController+Extensions.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 03/07/21.
//

import UIKit

extension UIViewController {
    private var activityIndicatorTag: Int { return 199999 }
    
    //Set custom navigation
    func setCustomNavigation(isLeftBarButton: Bool = true) {
        guard
            let navigationBar = self.navigationController?.navigationBar  else { return }
        
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = UIColor.black
        self.navigationController?.view.backgroundColor = UIColor.clear
        // Left button
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonClick))
        self.navigationItem.leftBarButtonItems = isLeftBarButton ? [backButton] : []
    }
    
    @objc func backButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Add activity indicator
    func startActivityIndicator(onMainThread main: Bool = true) {
        stopActivityIndicator(onMainThread: main)
        if main {
            DispatchQueue.main.async {
                self.addAcitivityIndicator()
            }
        } else {
            addAcitivityIndicator()
        }
    }
    
    private func addAcitivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.tag = self.activityIndicatorTag
        activityIndicator.center = self.view.center
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    //Remove acitvity indicator
    func stopActivityIndicator(onMainThread main: Bool = true) {
        if main {
             DispatchQueue.main.async {
                self.removeAcitivityIndicator()
             }
        } else {
            removeAcitivityIndicator()
        }
    }
    
    private func removeAcitivityIndicator() {
        if let activityIndicator = self.view.subviews.filter({ $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
