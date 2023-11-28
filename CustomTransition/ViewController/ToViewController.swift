//
//  ToViewController.swift
//  CustomTransition
//
//  Created by reyhan muhammad on 28/11/23.
//

import UIKit

class ToViewController: UIViewController, CustomTransitionEnabledVC {
    
    var interactionController: UIPercentDrivenInteractiveTransition?
    var customTransitionDelegate = TransitioningManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addPanGestureRecognizer()
        // Do any additional setup after loading the view.
    }

    func addPanGestureRecognizer(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleTransition(_:)))
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handleTransition(_ gestureRecognizer: UIPanGestureRecognizer){
        let translationX = gestureRecognizer.translation(in: view).x
        let percentageInDecimal = -translationX / view.frame.width
        
        switch gestureRecognizer.state {
        case .began:
            interactionController = UIPercentDrivenInteractiveTransition()
            customTransitionDelegate.interactionController = interactionController
            customTransitionDelegate.dismissalTransitionType = .swipeLeft
            dismiss(animated: true)
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
