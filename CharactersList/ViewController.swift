//
//  ViewController.swift
//  CharactersList
//
//  Created by  dollyally on 21.05.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let getAnimeRequestURL = "https://shikimori.one/api/animes"
    var localData: Anime?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
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
                    let responseData = try JSONDecoder().decode(Anime.self, from: data)
                    self?.localData = responseData
                    self?.tableView.reloadData()
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            }
        }.resume()
    }
}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localData?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.id, for: indexPath) as? MyTableViewCell else {
            return UITableViewCell()
        }
        
        let titles: Titles? = localData?.list[indexPath.row]
        cell.configure(with: titles)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true	)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let detailVC = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            let titles: Titles? = localData?.list[indexPath.row]
            detailVC.animeData = titles
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
