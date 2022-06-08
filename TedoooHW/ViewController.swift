//
//  ViewController.swift
//  TedoooHW
//
//  Created by Jeffery Widroff on 6/6/22.
//

import UIKit


class ViewController: UIViewController, CellDelegate {
        
    var commentViewController = CommentViewController()
    var content = ContentCollectionViewCell()
    var posts = [Post]()
        
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBar()
        getData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: view.frame.height / 8, width: view.frame.width, height: view.frame.height)
    }
    
    func addNavBar() {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 8)
        let navBar = UINavigationBar(frame: frame)
        navBar.backgroundColor = UIColor.green
        view.addSubview(navBar)
    }
    
    func getData() {
        
        TedoooRepository.shared.getFeed(maxId: nil) { (result) in
            
            do {
                try self.posts = result.get().posts
            } catch {
                print(error.localizedDescription)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.setupCollectionView()
        }
    }
    
    func setupCollectionView() {
        
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func present(indexPath: Int) {
        self.commentViewController.post = self.posts[indexPath]
        self.commentViewController.view.frame = self.view.frame
        
        present(commentViewController, animated: true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Create cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as! ContentCollectionViewCell
 
        cell.imageView.image = fetchImage(indexPath: indexPath.section, type: "image")
        cell.userImage.image = fetchImage(indexPath: indexPath.section, type: "avatar")
        cell.userImage.layer.cornerRadius = cell.userImage.frame.width / 2
        cell.nameView.text = posts[indexPath.section].user.username
        cell.descriptionView.text = posts[indexPath.section].text
        cell.likeCountLabel.text = "\(posts[indexPath.section].likes)"
        cell.delegate = self
        cell.commentCountLabel.text = "\(posts[indexPath.section].comments)"
        cell.cellIndex = indexPath.section
        return cell
    }
    
    func fetchImage(indexPath: Int, type: String) -> UIImage {
        
        var image = UIImage(named: "avatar")
        var url: URL?
        if type == "image" {
            url = URL(string: posts[indexPath].images[0])!

        } else if type == "avatar" {
            url = URL(string: posts[indexPath].user.avatar ?? "google.com")!
        }
        
        if let data = try? Data(contentsOf: (url ?? URL(string: "google.com"))!) {
            image = UIImage(data: data)
        }
        return image!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.width)
    }
}

