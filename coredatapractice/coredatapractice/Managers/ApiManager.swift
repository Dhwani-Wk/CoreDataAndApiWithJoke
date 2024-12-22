//
//  ApiManager.swift
//  coredatapractice
//
//  Created by Manthan Mittal on 15/12/2024.
//

import Foundation
import Alamofire

class ApiManager{
    
   let urlstr="https://official-joke-api.appspot.com/jokes/random/20"
    
    func fetchJokes(completionHandler: @escaping(Result<[JokeModel],Error>)-> Void) {
        
      
        
        AF.request(urlstr).responseDecodable(of: [JokeModel].self){response in
            switch response.result{
                
            case.success(let data):
                completionHandler(.success(data))
                
            case.failure(let error):
                completionHandler(.failure(error))
    }
        
        }
    }
}

