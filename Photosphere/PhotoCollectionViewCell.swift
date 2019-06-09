//
//  PhotoCollectionViewCell.swift
//  Photosphere
//
//  Created by Enzo Maruffa Moreira on 07/06/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoCount: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoCountContainer: UIView!
    
    var photoCollection: PhotoCollection!
    
    func setupCell(photoCollection: PhotoCollection) {
        self.photoCollection = photoCollection
        self.photoImage.image = photoCollection.photos.first?.photo
        self.photoCount.text = photoCollection.photos.count.description
    self.photoCountContainer.layer.cornerRadius = photoCountContainer.frame.width/2
        self.photoCountContainer.layer.shadowColor = UIColor.black.cgColor
        self.photoCountContainer.layer.shadowOpacity = 1
        self.photoCountContainer.layer.shadowOffset = .init(width: 1, height: 1)
        self.photoCountContainer.layer.shadowRadius = 3
        
        self.layer.cornerRadius = 10
    }
}
