//
//  NavigationCellView.swift
//  arlnc-tvOS
//

import UIKit

class NavigationCellView: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    func configure(name: String) {
        label.text = name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(label)
        label.constraints(top: nil, leading: nil, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 5))
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
