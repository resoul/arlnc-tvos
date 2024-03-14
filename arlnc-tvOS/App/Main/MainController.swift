//
//  MainController.swift
//  arlnc-tvOS
//

import UIKit

class MainController: UIViewController {
    private lazy var containerView = UIView()
    private lazy var navigationView = NavigationView()
    private(set) var selectedViewController: UIViewController?
    var viewControllers: [UIViewController] = [
        UIViewController(),
        UIViewController(),
        UIViewController(),
        UIViewController(),
        UIViewController(),
        UIViewController()
    ]
    var headlines: [String] = ["One", "Two", "Three", "Four", "Five", "Six"]
    
    weak var navigationWidth: NSLayoutConstraint?
    weak var containerWidth: NSLayoutConstraint?
    weak var leftContainerWidth: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(navigationView, containerView)
        navigationView.collectionView.delegate = self
        navigationView.collectionView.dataSource = self
        navigationView.backgroundColor = .black
        
        navigationView.constraints(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil)
        containerView.constraints(top: view.topAnchor, leading: nil, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        navigationWidth = navigationView.widthAnchor.constraint(equalToConstant: 330)
        containerWidth = containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 330)
        leftContainerWidth = containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 330)
        
        navigationWidth?.isActive = true
        containerWidth?.isActive = true
        leftContainerWidth?.isActive = true
        
        selectedViewController = viewControllers[0]
        addChildController(viewControllers[0])
    }
    
    private var isHidden = false
    
    private func updateAnimation() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, options: .layoutSubviews) {
                if self.isHidden {
                    self.navigationWidth?.constant = 330
                    self.leftContainerWidth?.constant = 330
                    self.containerWidth?.constant = UIScreen.main.bounds.width - 330
                } else {
                    self.navigationWidth?.constant = 90
                    self.leftContainerWidth?.constant = 90
                    self.containerWidth?.constant = UIScreen.main.bounds.width - 90
                }
                
                self.isHidden = !self.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension MainController {
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let view = context.previouslyFocusedView as? NavigationCellView {
            view.backgroundColor = .black
            view.label.textColor = .white
        }
        
        if let view = context.nextFocusedView as? NavigationCellView {
            view.backgroundColor = .white
            view.label.textColor = .black
        }
    }
}

// collection view layout
extension MainController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
}

// collection view delegate & collection view data source
extension MainController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cid", for: indexPath) as? NavigationCellView else {
            return UICollectionViewCell()
        }
        
        cell.configure(name: headlines[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let controller = selectedViewController else {
            return
        }
        removeChildController(controller)
        selectedViewController = viewControllers[indexPath.row]
        addChildController(viewControllers[indexPath.row])
    }
}


// append&remove child controllers
extension MainController {
    private func addChildController(_ childController: UIViewController) {
        addChild(childController)
        containerView.addSubview(childController.view)
        childController.view.frame = containerView.bounds
        childController.didMove(toParent: self)
    }

    private func removeChildController(_ childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
}
