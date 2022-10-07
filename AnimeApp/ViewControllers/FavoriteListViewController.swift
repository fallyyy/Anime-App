//
//  FavoriteListViewController.swift
//  AnimeApp
//
//  Created by  dollyally on 28.07.2022.
//

import UIKit

class FavoriteListViewController: UIViewController {
    var favoriteList = [Int:Bool]()
    var tempList = [Int]()
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...favoriteList.count {
            tempList.append(i)
        }
    }
    
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: MyTableViewCell.id) as? MyTableViewCell else {
            return UITableViewCell()
        }
 
        return cell
    }
}

