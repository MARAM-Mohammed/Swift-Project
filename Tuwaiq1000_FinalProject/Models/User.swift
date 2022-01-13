//
//  User.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 10/05/1443 AH.
//

import Foundation
import UIKit


struct User: Decodable {
    var id: String
    var firstName: String
    var lastName: String
    var picture: String?
    var phone: String?
    var email: String?
    var gender: String?
    var location: Location?
}
