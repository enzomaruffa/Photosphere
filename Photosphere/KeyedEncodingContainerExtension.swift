//
//  KeyedEncodingContainerExtension.swift
//  Photosphere
//
//  Created by Enzo Maruffa Moreira on 08/06/19.
//  Copyright © 2019 Enzo Maruffa Moreira. All rights reserved.
//

import UIKit

enum ImageEncodingQuality: CGFloat {
    case png = 0
    case jpegLow = 0.2
    case jpegMid = 0.5
    case jpegHigh = 0.75
}

extension KeyedEncodingContainer {
    
    mutating func encode(_ value: UIImage,
                         forKey key: KeyedEncodingContainer.Key,
                         quality: ImageEncodingQuality = .png) throws {
        var imageData: Data!
        if quality == .png {
            imageData = value.pngData()
        } else {
            imageData = value.jpegData(compressionQuality: quality.rawValue)
        }
        try encode(imageData, forKey: key)
    }
    
}

extension KeyedDecodingContainer {
    
    public func decode(_ type: UIImage.Type, forKey key: KeyedDecodingContainer.Key) throws -> UIImage {
        let imageData = try decode(Data.self, forKey: key)
        if let image = UIImage(data: imageData) {
            return image
        } else {
            //throw SDKError.imageConversionError
            return UIImage()
        }
    }
    
}
