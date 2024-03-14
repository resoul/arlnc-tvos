//
//  NavigationView.swift
//  arlnc-tvOS
//

import UIKit

class NavigationView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 15
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(NavigationCellView.self, forCellWithReuseIdentifier: "cid")
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        collectionView.constraints(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: frame.height / 2))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
