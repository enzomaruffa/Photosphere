//
//  Photo.swift
//  Photosphere
//
//  Created by Enzo Maruffa Moreira on 08/06/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

class Photo : Codable {
    
    var photo: UIImage
    var name: String
    
    internal init(photo: UIImage, name: String) {
        self.photo = photo
        self.name = name
    }
    
    // coding and decodng stuff
    private enum CodingKeys: String, CodingKey {
        case photo
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        photo = try container.decode(UIImage.self, forKey: .photo)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(photo, forKey: .photo)
        try container.encode(name, forKey: .name)
    }
    
    
}
