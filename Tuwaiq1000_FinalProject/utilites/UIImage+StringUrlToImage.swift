//
//  UIImage+StringUrlToImage.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 14/05/1443 AH.
//

import Foundation
import UIKit



extension UIImageView {
    func setImageFromStringUrl(stringUrl : String) {
        if let url = URL(string: stringUrl){
            if let imageDate = try? Data(contentsOf: url) {
               self.image = UIImage(data: imageDate)
            }
        }
    }
    
    func makeCircularImage(){
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderColor = UIColor(red:  26/255, green: 58/255, blue:87/255, alpha: 1).cgColor
    }
    }
