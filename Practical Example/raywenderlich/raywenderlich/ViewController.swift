//
//  ViewController.swift
//  raywenderlich
//
//  Created by Andy M on 08/10/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let networkingDelegate : NetworkingDelegate = RayWenderlichAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkingDelegate.getContent { result in
            switch result{
            case .success(let content):
                print(content)
                break
            case .failure(let error):
                break
            }
        }
    }


}

