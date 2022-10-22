//
//  Styles.swift
//  raywenderlich
//
//  Created by Andy M on 22/10/2022.
//

import UIKit

extension UIView{
    
    public func addShadow(shadowPath: CGPath? = nil) {
        self.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.16).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 6.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowPath = shadowPath
    }
    
    func pinTo(view: UIView, padding: CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(padding)).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(padding)).isActive = true
    }
}

extension UIColor{
    class var off_white_background: UIColor{ return UIColor(red: 248.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1)}
}
