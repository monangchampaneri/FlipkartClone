//
//  CategoryColellectionCell.swift
//  FlipkartPraticle
//
//  Created by Monang Champaneri on 24/01/24.
//

import UIKit
import SDWebImage

class CategoryColellectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCell(_ url:String){
   
        self.imgView.sd_setImage(with: URL(string: url)!) { (img, err, Cache, url) in
            if err != nil{
                self.imgView.image = img
            }
        }
    }
    
}
