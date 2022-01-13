//
//  PostAPI.swift
//  Tuwaiq1000_FinalProject
//
//  Created by MARAM on 15/05/1443 AH.
//

import Foundation
import Alamofire
import SwiftyJSON


class PostAPI : API {
    
    static func getAllPosts(page: Int , tag: String? , completionHandler: @escaping ([Post] , Int ) -> ()) {
        
        var url = baseURL + "/post"
        if var myTag = tag {
            myTag = myTag.trimmingCharacters(in: .whitespaces)
            url = "\(baseURL)/tag/\(myTag)/post"
        }
        
        let params = [
            "page": "\(page)",
            "linit": "5"
        ]
       
        
        AF.request(url,parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseJSON { response in
        let jsonData = JSON(response.value)
        let data = jsonData["data"] // data_Key
        let total = jsonData["total"].intValue
        let decoder = JSONDecoder()
        do{
            let posts = try decoder.decode([Post].self, from: data.rawData())
            completionHandler(posts , total)
        }catch let error{
            print(error)
        }
        print(data)
       
    }
}
    
    static func addNewPost(image: String , text: String, userId: String , complationHandler: @escaping () -> ()){
        
        let url = "\(baseURL)/post/create"
        let params = [
            "owner": userId,
            "text": text,
            "image": image
        ]
        
        AF.request(url, method: .post , parameters: params , encoder: JSONParameterEncoder.default ,headers: headers).validate().responseJSON { response in
            
            switch response.result{
            case .success:
                    complationHandler()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getPostComments(id: String, completionHandler: @escaping ([Comment]) -> ()){
        
        let url = "\(baseURL)/post/\(id)/comment"
        
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do{
                let comments = try decoder.decode([Comment].self, from: data.rawData())
                completionHandler(comments)
            }catch let error{
                print(error)
            }
        }
    }

    static func addBNewCommentToPost( postId: String, userId: String , message: String ,complationHandler: @escaping () -> ()){
        
        let url = "\(baseURL)/comment/create"
        let params = [
            "post": postId,
            "message": message,
            "owner": userId
        ]
        
        AF.request(url, method: .post , parameters: params , encoder: JSONParameterEncoder.default ,headers: headers).validate().responseJSON { response in
            
            switch response.result{
            case .success:
                    complationHandler()
            case .failure(let error):
                print(error)
            }
           
        }
    }
    
    
    static func postDelete( postId: String, userId: String,complationHandler: @escaping () -> ()){
        
        let url = "\(baseURL)/post/\(postId)"
        let params = [
            "id": postId,
            "owner": userId
        ]
        
        AF.request(url, method: .delete , parameters: params , encoder: JSONParameterEncoder.default ,headers: headers).validate(statusCode: 200 ..< 299).responseJSON { response in
            
            switch response.result{
            case .success:
                    complationHandler()
            case .failure(let error):
                print(error)
            }
           
        }
    }
    
    

    static func getAllTags(completionHandler: @escaping ([String]) -> ()) {
        
        let url = baseURL + "/tag"

       AF.request(url, headers: headers).responseJSON { response in
        let jsonData = JSON(response.value)
        let data = jsonData["data"] // data_Key
        let decoder = JSONDecoder()
        do{
            let tags = try decoder.decode([String].self, from: data.rawData())
            completionHandler(tags)
        }catch let error{
            print(error)
        }
        print(data)
       
    }
}
    
}

