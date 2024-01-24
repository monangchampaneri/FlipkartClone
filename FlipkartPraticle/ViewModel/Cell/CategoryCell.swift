//
//  CategoryCell.swift
//  FlipkartPraticle
//
//  Created by Monang Champaneri on 24/01/24.
//

import UIKit

class CategoryCell: UITableViewCell {
    var categoryArray:[String] = [
        "https://rukminim2.flixcart.com/flap/3240/3060/image/033f3268031fa0ba.jpg?q=80",
        "https://rukminim2.flixcart.com/flap/1620/1530/image/0f3d008be60995d4.jpg?q=80",
        "https://rukminim2.flixcart.com/flap/1620/1530/image/42f9a853f9181279.jpg?q=80",
        "https://rukminim2.flixcart.com/flap/1620/1530/image/cbcb478744635781.jpg?q=80",
        "https://rukminim2.flixcart.com/flap/1620/1530/image/913e96c334d04395.jpg?q=80",
        "https://rukminim2.flixcart.com/fk-p-flap/1620/1530/image/07d71cbddb6083ad.jpg?q=80",
        "https://rukminim2.flixcart.com/flap/1620/1530/image/4be8a679014497f0.png?q=80",
        "https://rukminim2.flixcart.com/flap/1620/1530/image/6ecb75e51b607880.jpg?q=80",
        "https://rukminim2.flixcart.com/flap/1620/1530/image/3e6d75f631ab6055.jpg?q=80",
        "https://rukminim2.flixcart.com/flap/1620/1530/image/89d809684711712a.jpg?q=80",
        "https://rukminim2.flixcart.com/fk-p-flap/1620/1530/image/4b0a064d53b4ff28.jpg?q=80",
        "https://rukminim2.flixcart.com/fk-p-flap/1010/960/image/4b0a064d53b4ff28.jpg?q=80"]
                            
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
extension CategoryCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
           return CGSize(width: 100, height: 100)
       }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryColellectionCell", for: indexPath) as? CategoryColellectionCell else{
            return UICollectionViewCell()
        }
        
        cell.setupCell(categoryArray[indexPath.item])
        return cell
    }
    
    
}
