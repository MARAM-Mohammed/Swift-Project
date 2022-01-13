//
//  PostCell.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 10/05/1443 AH.
//

import UIKit

class PostCell: UITableViewCell {
    
    var tags:[String] = []

    @IBOutlet weak var tagsCollectioView: UICollectionView!{
        didSet{
            tagsCollectioView.delegate = self
            tagsCollectioView.dataSource = self
        }
    }
    @IBOutlet weak var userStackView: UIStackView!{
       didSet{
            userStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userStackViewTapped)))
        }
    }
    @IBOutlet weak var likesNumberLabel: UILabel!
    @IBOutlet weak var BackView: UIView!{
    didSet{
             BackView.layer.shadowColor = UIColor.gray.cgColor 
             BackView.layer.shadowOpacity = 0.3
             BackView.layer.shadowOffset = CGSize(width: 0, height: 10)
             BackView.layer.shadowRadius = 10
             BackView.layer.cornerRadius = 7
        }
    }
    @IBOutlet weak var postTextLabel: UILabel!


    
    @IBOutlet weak var postImageView: UIImageView!
  
    @IBOutlet weak var userNameLabel: UILabel!
  
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func userStackViewTapped(){
        NotificationCenter.default.post(name: NSNotification.Name("userStackViewTapped"), object: nil, userInfo: ["cell": self])
    }
}

extension PostCell: UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostTagCell", for: indexPath) as! PostTagCell
        cell.tagNameLabel.text = tags[indexPath.row]
        
        return cell
    }
    
    
}
