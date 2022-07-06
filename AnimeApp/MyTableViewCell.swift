//
//  MyTableViewCell.swift
//  AnimeApp
//
//  Created by  dollyally on 26.05.2022.
//

import UIKit
import Kingfisher

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    func configure(with data: Title?) {
        guard let data = data else {
            return
        }
        
        myLabel.text = data.name
        
        if let url = URL(string: data.image.preview) {
            avatarImageView.kf.setImage(with: url)
        }
    }
}

