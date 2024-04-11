//
//  UIImage+Extension .swift
//  BettaBank
//
//  Created by Dmitry Gorbunow on 11/8/23.
//

import UIKit

extension UIImage {
    class func getSegRect(color: CGColor, andSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage ?? UIImage()
    }
    
    static var chevronLeft: UIImage {
        guard let image = UIImage(systemName: "chevron.left") else { return UIImage() }
        return image
    }
    
    static var chevronRight: UIImage {
        guard let image = UIImage(systemName: "chevron.right") else { return UIImage() }
        return image
    }
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        let widthRatio = newSize.width / size.width
        let heightRatio = newSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { [weak self] _ in
            self?.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}
