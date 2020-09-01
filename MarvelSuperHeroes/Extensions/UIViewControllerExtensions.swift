import UIKit

extension UIViewController {

    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
