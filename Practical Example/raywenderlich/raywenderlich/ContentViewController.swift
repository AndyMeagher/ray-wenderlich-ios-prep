//
//  ViewController.swift
//  raywenderlich
//
//  Created by Andy M on 08/10/2022.
//

import UIKit

class ContentViewController: UITableViewController {
    private let contentManager = ContentManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
            do{
                try await contentManager.getContent()
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }catch NetworkError.requestError(let message) {
                self.displayAlert(message: message)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentManager.content.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var config = cell.defaultContentConfiguration()
        config.text = contentManager.content[indexPath.row].attributes.name
        config.secondaryText = contentManager.content[indexPath.row].attributes.content_type.rawValue
        cell.contentConfiguration = config
        return cell
    }
    
    private func displayAlert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}

