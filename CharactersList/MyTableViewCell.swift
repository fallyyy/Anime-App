//
//  MyTableViewCell.swift
//  CharactersList
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
        
    func configure(with data: Titles?) {
        myLabel.text = data?.name ?? "Empty" 
        
        if let stringUrl = data?.preview,
           let url = URL(string: stringUrl) {
            avatarImageView.kf.setImage(with: url)
        }
    }
}

