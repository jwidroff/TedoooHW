//
//  CommentsCollectionViewCell.swift
//  TedoooHW
//
//  Created by Jeffery Widroff on 6/7/22.
//

import UIKit

class CommentsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CommentsCollectionViewCell"
            
    var nameLbl = UILabel()
    
    var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        return imageView
        
    }()
    
    var bodyTextLbl = UILabel()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.gray
        
        userImage.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        nameLbl.frame = CGRect(x: userImage.frame.maxX + 20, y: 10, width: 500, height: 40)
        bodyTextLbl.frame = CGRect(x: 10, y: nameLbl.frame.maxY + 10, width: 500, height: 75)
        bodyTextLbl.numberOfLines = 1
        
        contentView.addSubview(userImage)
        contentView.addSubview(nameLbl)
        contentView.addSubview(bodyTextLbl)
        userImage.image = UIImage(named: "avatar")
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
}
