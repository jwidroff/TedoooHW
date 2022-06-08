//
//  CommentViewController.swift
//  TedoooHW
//
//  Created by Jeffery Widroff on 6/7/22.
//

import UIKit

class CommentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var post: Post?
    var comments = [Comment]()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView

    }()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var userImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar"))
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        return imageView

    }()

    var nameView = UITextView()
    var descriptionView = UILabel()
    var likeButton = UIButton()
    var commentButton = UIButton()
    var likeCountLabel = UILabel()
    var commentCountLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        TedoooRepository.shared.getComments(postId: post!.id, maxId: nil) { (result) in
            
            do {
                try self.comments = result.get().comments
            } catch {
                print(error.localizedDescription)
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.setupUI()
            self.setupCollectionView()
        }
    }

    func setupCollectionView() {
        
        collectionView.register(CommentsCollectionViewCell.self, forCellWithReuseIdentifier: CommentsCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func setupUI() {
        
        self.view.backgroundColor = .white

        let topLeftCorner = CGRect(x: 20, y: 20, width: 40, height: 40)
        userImage.frame = topLeftCorner

        let next2TopLeftCorner = CGRect(x: 70, y: 20, width: view.frame.width - 70, height: 40)
        nameView.frame = next2TopLeftCorner

        let middleArea = CGRect(x: view.frame.width/20, y: userImage.frame.maxY + 5, width: view.frame.width, height: view.frame.height/10)
        descriptionView.frame = middleArea

        let mainArea = CGRect(x: 0, y: middleArea.maxY + 5, width: view.frame.width, height: (view.frame.height/2) - 20)
        imageView.frame = mainArea

        let bottomLeftCorner = CGRect(x: view.frame.width/20, y: mainArea.maxY + 5, width: 30, height: view.frame.height/15)
        likeButton.frame = bottomLeftCorner

        let next2BottomLeftCorner = CGRect(x: userImage.frame.maxY + 25, y: mainArea.maxY + 5, width: 30, height: view.frame.height/15)
        commentButton.frame = next2BottomLeftCorner
        
        let bottomLeftCornerX = CGRect(x: view.frame.width/20 + 30, y: mainArea.maxY + 5, width: view.frame.width/10, height: view.frame.height/15)
        likeCountLabel.frame = bottomLeftCornerX
        
        let next2BottomLeftCornerX = CGRect(x: userImage.frame.maxY + 55, y: mainArea.maxY + 5, width: view.frame.width/10, height: view.frame.height/15)
        commentCountLabel.frame = next2BottomLeftCornerX
        
        let commentArea = CGRect(x: 0, y: next2BottomLeftCornerX.maxY + 20, width: view.frame.width, height: 500)
        
        collectionView.frame = commentArea
        collectionView.backgroundColor = .white
        userImage.image = fetchImage(type: "avatar")
        nameView.text = post?.user.username
        descriptionView.text = post?.text
        descriptionView.numberOfLines = 3
        likeButton.setTitle("👍", for: .normal)
        commentButton.setTitle("💬", for: .normal)
        likeCountLabel.text = "\(post?.likes ?? 0)"
        commentCountLabel.text = "\(post?.comments ?? 0)"
        imageView.image = fetchImage(type: "image")
        
        view.addSubview(imageView)
        view.addSubview(userImage)
        view.addSubview(nameView)
        view.addSubview(descriptionView)
        view.addSubview(likeButton)
        view.addSubview(commentButton)
        view.addSubview(likeCountLabel)
        view.addSubview(commentCountLabel)
    }

    func fetchImage(type: String) -> UIImage {
        
        var image = UIImage(named: "avatar")
        var url: URL?
        if type == "image" {
            url = URL(string: post!.images[0])!

        } else if type == "avatar" {
            url = URL(string: post?.user.avatar ?? "google.com")!
        }
        
        if let data = try? Data(contentsOf: (url ?? URL(string: "google.com"))!) {
            image = UIImage(data: data)
        }
        return image!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 8)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentsCollectionViewCell.identifier, for: indexPath) as! CommentsCollectionViewCell

        cell.nameLbl.text = comments[indexPath.section].user.username
        let url = URL(string: comments[indexPath.section].user.avatar ?? "google.com")!
        if let data = try? Data(contentsOf: url) {
            cell.userImage.image = UIImage(data: data)
        }
        
        cell.bodyTextLbl.text = comments[indexPath.section].text

        return cell
    }
    
}
