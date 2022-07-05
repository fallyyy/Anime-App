//
//  DatailViewController.swift
//  CharactersList
//
//  Created by  dollyally on 07.06.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    var brawlerData: Brawler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLabel.text = brawlerData?.name
    }
}
