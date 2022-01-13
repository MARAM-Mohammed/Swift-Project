//
//  Post.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 09/05/1443 AH.
//

import Foundation
import UIKit


// Mapping

struct Post : Decodable{
    var id: String
    var image: String
    var likes: Int
    var text: String
    var owner: User
    var tags: [String]?
}
