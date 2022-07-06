//
//  DatailViewController.swift
//  CharactersList
//
//  Created by  dollyally on 07.06.2022.
//

import UIKit
import Kingfisher

// TODO: Добавить детальную информацию о тайтле
class DetailViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    var animeData: Title?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLabel.text = animeData?.name
    }
}
