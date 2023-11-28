//
//  ViewController.swift
//  CustomTransition
//
//  Created by reyhan muhammad on 28/11/23.
//

import UIKit

class FromViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }

    func presentToVC(){
        let vc = ToViewController()
        present(vc, animated: true)
    }

}

