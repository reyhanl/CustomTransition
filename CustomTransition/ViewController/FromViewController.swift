//
//  ViewController.swift
//  CustomTransition
//
//  Created by reyhan muhammad on 28/11/23.
//

import UIKit

class FromViewController: UIViewController {
    
    var customTransitionDelegate = TransitioningManager()
    var interactionController: UIPercentDrivenInteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        addPanGestureRecognizer()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func addPanGestureRecognizer(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleTransition(_:)))
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(panGesture)
    }

    func presentToVC(){
        let vc = ToViewController()
        
        interactionController = UIPercentDrivenInteractiveTransition()
        
        vc.transitioningDelegate = vc.customTransitionDelegate
        vc.customTransitionDelegate.interactionController = interactionController
        vc.customTransitionDelegate.presentationTransitionType = .swipeRight
        vc.customTransitionDelegate.dismissalTransitionType = .swipeLeft
        vc.modalPresentationStyle = .custom
        present(vc, animated: true)
    }

    @objc func handleTransition(_ gestureRecognizer: UIPanGestureRecognizer){
        let translationX = gestureRecognizer.translation(in: view).x
        let percentageInDecimal = translationX / view.frame.width
        
        switch gestureRecognizer.state {
        case .began:
            presentToVC()
        case .changed:
            print(percentageInDecimal)
            interactionController?.update(percentageInDecimal)
        case .ended:
            if percentageInDecimal > 0.5{
                interactionController?.finish()
            }else{
                interactionController?.cancel()
            }
        default:
            break
        }
    }
}

protocol CustomTransitionEnabledVC{
    var interactionController: UIPercentDrivenInteractiveTransition? { get set }
    var customTransitionDelegate: TransitioningManager {get set}
}
