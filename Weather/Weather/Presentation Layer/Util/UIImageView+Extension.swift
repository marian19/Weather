//
//  UIImageView+Extension.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    func setImageFrom(icon: String) {
        let image = getImageFromDocuments(icon: icon)
        
        if image != nil{
            self.image = image
        }else{
            let httpClient = AlamofireClient.sharedInstance
            
            httpClient.downloadImageWith(icon: icon) { (image, error) in
                if let image = image{
                    self.image = image
                    self.saveImageToDocuments(icon: icon, image: image)
                }
            }
        }
    }
    
    private func getImageFromDocuments(icon: String) -> UIImage? {
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("\(icon).png").path
        if FileManager.default.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)
        }
        return nil
    }
    
    private func saveImageToDocuments(icon: String, image: UIImage){
        
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("\(icon).png")
            if let pngImageData = UIImagePNGRepresentation(image) {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
        } catch { }
    }
}
