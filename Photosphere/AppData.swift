//
//  Model.swift
//  Photosphere
//
//  Created by Enzo Maruffa Moreira on 07/06/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class AppData {
    static let instance = AppData()
    
    var photoCollections: [PhotoCollection] {
        didSet {
            let defaults = UserDefaults.standard
            
            print(photoCollections)
            
            // Use PropertyListEncoder to convert Player into Data / NSData
            defaults.set(try? PropertyListEncoder().encode(photoCollections), forKey: "photoCollections")
        }
    }
    
    private init() {
        photoCollections = []
        
        let defaults = UserDefaults.standard
        guard let photoCollectionsData = defaults.object(forKey: "photoCollections") as? Data else {
            return
        }
        
        guard let photoCollections = try? PropertyListDecoder().decode([PhotoCollection].self, from: photoCollectionsData) else {
            return
        }
        
        self.photoCollections = photoCollections
    }
}
