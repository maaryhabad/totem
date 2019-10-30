//
//  PrincipalViewController.swift
//  totem
//
//  Created by José Guilherme Bestel on 29/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Large title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //Left Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "+", style: .done, target: self, action: #selector(self.action(sender:)))
    }
    

    //Definir para qual  tela irá
    //TODO: Fazer uma  segue@objc
    @objc func action(sender: UIBarButtonItem) {
        print("hjxdbsdhjbv")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
