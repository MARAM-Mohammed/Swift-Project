//
//  Comment.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 11/05/1443 AH.
//

import Foundation


struct Comment: Decodable {
    var id: String
    var message: String
    var owner: User
}
