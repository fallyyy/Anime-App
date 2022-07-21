//
//  ViewController.swift
//  AnimeApp
//
//  Created by  dollyally on 21.05.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    // TODO: Сделать пагинацию для таблицы
    private let getAnimeRequestURL = "\(Constants.domain)/api/animes?page=1&limit=50"
    private var localData: [Title] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setupSearchBar()
        getData()
    }
    
    func getData() {
        guard let url = URL(string: getAnimeRequestURL) else {
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
    
    // TODO: Для поиска
      func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
   
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.id, for: indexPath) as? MyTableViewCell else {
            return UITableViewCell()
        }
        
        let title = localData[indexPath.row]
        cell.configure(with: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true	)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let detailVC = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            let title = localData[indexPath.row]
            detailVC.animeData = title
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
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

