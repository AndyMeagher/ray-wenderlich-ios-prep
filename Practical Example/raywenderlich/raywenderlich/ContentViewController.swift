//
//  ViewController.swift
//  raywenderlich
//
//  Created by Andy M on 08/10/2022.
//

import UIKit

class ContentViewController: UITableViewController {
    private let contentManager = ContentManager()
    
    private var segmentControl: UISegmentedControl!
    
    @objc func segmentChanged(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createSegmentControl()
        self.loadContent()
    }
    
    private func loadContent(){
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
    
    private func createSegmentControl(){
        self.segmentControl = UISegmentedControl(items:["Videos", "Articles", "All"])
        self.segmentControl.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 40)
        self.segmentControl.selectedSegmentIndex = 0
        self.segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        self.tableView.tableHeaderView = self.segmentControl
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentManager.getContent(with: segmentControl.selectedSegmentIndex).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var config = cell.defaultContentConfiguration()
        let content = contentManager.getContent(with: segmentControl.selectedSegmentIndex)[indexPath.row]
        config.text = content.attributes.name
        config.secondaryText = content.attributes.content_type.rawValue
        cell.contentConfiguration = config
        return cell
    }
    
    private func displayAlert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}

