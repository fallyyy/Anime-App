//
//  MyTableViewCell.swift
//  AnimeApp
//
//  Created by  dollyally on 26.05.2022.
//

import UIKit
import Kingfisher

protocol MyTableViewCellDelegate: AnyObject {
    func didTapFavourite(row: Int, isFavourite: Bool)
}

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    
    weak var delegate: MyTableViewCellDelegate?
    private var row: Int?
    private var isFavourite: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHeartButton))
        heartImageView.addGestureRecognizer(tapGestureRecognizer)
    }
        
    func configure(with data: Title?, row: Int, isFavourite: Bool) {
        self.row = row
        self.isFavourite = isFavourite
        
        guard let data = data else {
            return
        }
        
        if let url = URL(string: data.image.preview) {
            avatarImageView.kf.setImage(with: url)
        }
                
        myLabel.text = data.name
        
        let imageName = isFavourite ? "filledHeart" : "heart"
        heartImageView.image = UIImage(named: imageName)
        heartImageView.isUserInteractionEnabled = true
    }
    
    @objc private func didTapHeartButton() {
        guard let row = row,
              let isFavourite = isFavourite else {
            return
        }
        
        delegate?.didTapFavourite(row: row, isFavourite: isFavourite)
    }
}

