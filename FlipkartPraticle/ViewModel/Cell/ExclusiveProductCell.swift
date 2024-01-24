//
//  CategoryCell.swift
//  FlipkartPraticle
//
//  Created by Monang Champaneri on 24/01/24.
//

import UIKit

class ExclusiveProductCell: UITableViewCell {
    var categoryArray:[String] = [
        "https://rukminim2.flixcart.com/fk-p-flap/750/800/image/364ebb91a1c3f207.jpg?q=80",
        "https://rukminim2.flixcart.com/fk-p-flap/750/800/image/ee73920532b82e1c.png?q=80",
        "https://rukminim2.flixcart.com/fk-p-flap/750/800/image/b0affcf66086bcaf.jpeg?q=80",
       ]
                            
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }
    func configCell(){
        
        self.collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension ExclusiveProductCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
           return CGSize(width: self.contentView.bounds.width/3, height: self.contentView.bounds.height)
       }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExclusiveColellectionCell", for: indexPath) as? ExclusiveColellectionCell else{
            return UICollectionViewCell()
        }
        
        cell.setupCell(categoryArray[indexPath.item])
        return cell
    }
    
    
}
