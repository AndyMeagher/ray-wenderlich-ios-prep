//
//  ContentTableViewCell.swift
//  raywenderlich
//
//  Created by Andy M on 09/10/2022.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    
    let stackView = UIStackView()
    let cardView = UIView()
    var cardImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray

        cardView.backgroundColor = .white
        contentView.backgroundColor = .off_white_background
        contentView.pinTo(view: cardView, padding: 16)
        stackView.axis = .vertical
        stackView.spacing = 16
        cardView.pinTo(view: stackView, padding: 16)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.layer.cornerRadius = 5
        cardView.layoutIfNeeded()
        cardView.addShadow(shadowPath: UIBezierPath(roundedRect: cardView.bounds, cornerRadius: 5).cgPath)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with content: Content){
        
        cardImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        cardImageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(cardImageView)
        self.loadImage(from: content.attributes.card_artwork_url)
        
        let titleLabel = UILabel()
        titleLabel.text = content.attributes.name
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.sizeToFit()
        stackView.addArrangedSubview(titleLabel)

        let descriptionLabel = UILabel()
        descriptionLabel.text = content.attributes.description_plain_text
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.sizeToFit()
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    func loadImage(from urlString: String) {
        ImageLoader.loadImage(from: urlString) { image in
            self.cardImageView.image = image
            self.cardImageView.sizeToFit()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for v in stackView.arrangedSubviews{
            v.removeFromSuperview()
        }
    }

}
