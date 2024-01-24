//
//  BannerCell.swift
//  FlipkartPraticle
//
//  Created by Monang Champaneri on 24/01/24.
//

import UIKit
import ImageSlideshow

class BannerCell: UITableViewCell {
    let sdWebImageSource = [SDWebImageSource(urlString: "https://rukminim2.flixcart.com/fk-p-flap/1000/440/image/304666bb4918e382.jpg?q=80")!,
                            SDWebImageSource(urlString: "https://rukminim2.flixcart.com/fk-p-flap/480/210/image/ad2afccece1e58a0.jpg?q=20")!,
                            SDWebImageSource(urlString: "https://rukminim2.flixcart.com/fk-p-flap/480/210/image/8ea041fa6a80945f.jpeg?q=20")!]
    @IBOutlet weak var imgSliderView: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(){
        imgSliderView.slideshowInterval = 5.0
        imgSliderView.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: 10))
        imgSliderView.contentScaleMode = UIViewContentMode.scaleAspectFill
        imgSliderView.pageIndicator = UIPageControl.withSlideshowColors()
        
        imgSliderView.setImageInputs(sdWebImageSource)
           // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        imgSliderView.activityIndicator = DefaultActivityIndicator()
        imgSliderView.delegate = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension BannerCell:ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
