//
//  DatailViewController.swift
//  AnimeApp
//
//  Created by  dollyally on 07.06.2022.
//

import UIKit
import Kingfisher

// TODO: Добавить детальную информацию о тайтле
class DetailViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var russianNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var animeImageView: UIImageView!
    var animeData: Title?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLabel.text = animeData?.name
        russianNameLabel.text = animeData?.russian
        statusLabel.text = animeData?.status
        episodesLabel.text = animeData?.status

        animeImageView.contentMode = .scaleAspectFit
        
        if let urlString = animeData?.image.original,
           let url = URL(string: urlString) {
            animeImageView.kf.setImage(with: url)
        }
       
    }
}
 
