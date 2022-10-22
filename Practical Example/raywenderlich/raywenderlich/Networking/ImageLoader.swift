//
//  ImageLoader.swift
//  raywenderlich
//
//  Created by Andy M on 22/10/2022.
//

import UIKit

class ImageLoader{
    
    class func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let data = UserDefaults.standard.data(forKey: urlString){
            completion(UIImage(data: data))
        }else if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    UserDefaults.standard.setValue(data, forKey: urlString)
                    completion(UIImage(data: data))
                }
            }
            task.resume()
        }
    }
}
