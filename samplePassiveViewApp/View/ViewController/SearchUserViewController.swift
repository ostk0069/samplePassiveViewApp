//
//  SearchUserViewController.swift
//  samplePassiveViewApp
//
//  Created by Takuma Osada on 2019/04/28.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import UIKit

final class SearchUserViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private var presenter: SearchUserPresenterInput!

    func inject(presenter: SearchUserPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.didTapSearchButton(text: searchBar.text)
    }
}

extension SearchUserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        
        if let user = presenter.user(forRow: indexPath.row) {
            cell.configure(user: user)
        }
        return cell
    }
}

extension SearchUserViewController: SearchUserPresenterOutput {
    
    func updateUsers(_ users: [User]) {
        tableView.reloadData()
    }
    
    func transitionToUserDetail(userName: String) {
        let userDetailVC = UIStoryboard(
            name: "UserDetail",
            bundle: nil
            ).instantiateInitialViewController() as! UserDetailViewController
        let model = UserDetailModel(name: userName)
        let presenter = UserDetailPresenter(
            name: userName,
            view: userDetailVC,
            model: model
        )
        userDetailVC.inject(presenter: presenter)
        
        navigationController?.pushViewController(userDetailVC, animated: true)
        
    }
}
