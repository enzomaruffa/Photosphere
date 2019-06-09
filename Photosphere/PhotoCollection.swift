//
//  PhotoCollection.swift
//  Photosphere
//
//  Created by Enzo Maruffa Moreira on 07/06/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class PhotoCollection: Codable {
    
    var photos: [Photo]
    
    init(photos: [Photo]) {
        self.photos = photos
    }
    
    
}
