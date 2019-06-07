//
//  PhotoCollectionViewCell.swift
//  Photosphere
//
//  Created by Enzo Maruffa Moreira on 07/06/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    var photoCollection: PhotoCollection!
    
    func setupCell(photoCollection: PhotoCollection) {
        self.photoCollection = photoCollection
        self.photoImage.image = photoCollection.photos.first!
    }
}
