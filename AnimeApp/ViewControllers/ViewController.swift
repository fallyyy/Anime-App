//
//  ViewController.swift
//  AnimeApp
//
//  Created by  dollyally on 21.05.2022.
//

import UIKit

// TODO: Сделать пагинацию для таблицы
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var favoriteAnime = [Int: Bool]()
    var isDataLoading = false
    var pageNo = 0
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var localData: [Title] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        
        setupSearchBar()
        getData()
    }
    
    // MARK: Для поиска
      func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
}

// MARK: - Таблица.
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.id, for: indexPath) as? MyTableViewCell else {
            return UITableViewCell()
        }
        
        let title = localData[indexPath.row]
        let isFavourite = favoriteAnime[indexPath.row] == true
        cell.configure(with: title, row: indexPath.row, isFavourite: isFavourite)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            let title = localData[indexPath.row]
            detailVC.animeData = title
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
        isDataLoading = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }

// Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        let firstCalc = tableView.contentOffset.y + tableView.frame.size.height
        let secondCalc = tableView.contentSize.height
        if (firstCalc >= secondCalc) {
            if !isDataLoading {
                isDataLoading = true
                pageNo += 1
                getData(page: pageNo)
            }
        }
    }
}

// MARK: - Данные.
extension ViewController {
    func getData(page: Int = 0, limit: Int = 50) {
        guard let url = URL(string: "\(Constants.domain)/api/animes?page=\(page)&limit=\(limit)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                guard error == nil,
                      let data = data else {
                    print("Some Error")
                    return
                }

                do {
                    let responseData = try JSONDecoder().decode([Title].self, from: data)
                    self?.localData += responseData
                    self?.tableView.reloadData()
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            }
        }.resume()
    }
}

// MARK: - SearchBar.
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 3 else {
            return
        }
        
        guard let url = URL(string: "\(Constants.domain)/api/animes?page=1&limit=50&search=\(searchText)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                guard error == nil,
                      let data = data else {
                    print("Some Error")
                    return
                }

                do {
                    let responseData = try JSONDecoder().decode([Title].self, from: data)
                    self?.localData = responseData
                    self?.tableView.reloadData()
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            }
        }.resume()
    }
}

// MARK: - Did tap favourite button.
extension ViewController: MyTableViewCellDelegate {
    func didTapFavourite(row: Int, isFavourite: Bool) {
        favoriteAnime[row] = !isFavourite
    }
}
