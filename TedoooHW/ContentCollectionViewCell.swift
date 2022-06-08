//
//  ContentCollectionViewCell.swift
//  TedoooHW
//
//  Created by Jeffery Widroff on 6/6/22.
//

import UIKit

 protocol CellDelegate {
    
     func present(indexPath: Int) 
}


class ContentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ContentCollectionViewCell"
    
    var delegate: CellDelegate?
    
    var cellIndex = Int()
    
    var nameView = UITextView()
    
    var descriptionView = UILabel()
    
    var likeButton = UIButton()
    
    var commentButton = UIButton()
    
    var likeCountLabel = UILabel()
    
    var commentCountLabel = UILabel()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    func addViews() {
        imageView.image = UIImage(named: "image")
        userImage.image = UIImage(named: "avatar")
        descriptionView.numberOfLines = 3
        likeButton.setTitle("👍", for: .normal)
        setupCommentButton()
        contentView.addSubview(imageView)
        contentView.addSubview(userImage)
        contentView.addSubview(nameView)
        contentView.addSubview(descriptionView)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(commentCountLabel)
    }
    
    func setupCommentButton() {
        commentButton.setTitle("💬", for: .normal)
        commentButton.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let topLeftCorner = CGRect(x: contentView.frame.width/20, y: contentView.frame.width/20, width: contentView.frame.width/10, height: contentView.frame.height/10)
        userImage.frame = topLeftCorner
        
        let next2TopLeftCorner = CGRect(x: userImage.frame.maxY + 5, y: contentView.frame.width/20, width: contentView.frame.width, height: contentView.frame.height/10)
        nameView.frame = next2TopLeftCorner
        
        let middleArea = CGRect(x: contentView.frame.width/20, y: userImage.frame.maxY + 5, width: contentView.frame.width, height: contentView.frame.height/10)
        descriptionView.frame = middleArea
        
        let mainArea = CGRect(x: 0, y: middleArea.maxY + 5, width: contentView.frame.width, height: (contentView.frame.height/3*2) - 20)
        imageView.frame = mainArea
        
        let bottomLeftCorner = CGRect(x: contentView.frame.width/20, y: mainArea.maxY + 5, width: 30, height: contentView.frame.height/15)
        likeButton.frame = bottomLeftCorner
        
        let next2BottomLeftCorner = CGRect(x: userImage.frame.maxY + 25, y: mainArea.maxY + 5, width: 30, height: contentView.frame.height/15)
        commentButton.frame = next2BottomLeftCorner
        
        let bottomLeftCornerX = CGRect(x: contentView.frame.width/20 + 30, y: mainArea.maxY + 5, width: contentView.frame.width/10, height: contentView.frame.height/15)
        likeCountLabel.frame = bottomLeftCornerX
        
        let next2BottomLeftCornerX = CGRect(x: userImage.frame.maxY + 55, y: mainArea.maxY + 5, width: contentView.frame.width/10, height: contentView.frame.height/15)
        commentCountLabel.frame = next2BottomLeftCornerX
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
                        
        delegate?.present(indexPath: cellIndex)
    }
 }
