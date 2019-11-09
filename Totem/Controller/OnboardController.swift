//
//  ViewController.swift
//  totem
//
//  Created by Kevin Katzer on 30/10/19.
//  Copyright © 2019 Kevin Katzer. All rights reserved.
//

import UIKit

class OnboardController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var circle1: UIImageView!
    @IBOutlet weak var circle2: UIImageView!
    @IBOutlet weak var circle3: UIImageView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OnboardCell
        
        cell.start.layer.cornerRadius = 5
        
        switch indexPath.row {
        case 0:
            cell.image.image = UIImage(named: "Onboard 1")
            cell.label.text = "Esse é o TOTEM,\n\num avatar para conectar"
            cell.start.isHidden = true
        case 1:
            cell.image.image = UIImage(named: "Onboard 2")
            cell.label.text = "Tenha um canal de comunicação direto com quem você quiser com a sua voz e sua personalidade"
            cell.start.isHidden = true
        default:
            cell.image.image = UIImage(named: "Onboard 3")
            cell.label.text = "Seu TOTEM fala por você para te aproximar das pessoas de quem você gosta de um jeito único"
            cell.start.isHidden = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(CGSize(width: self.view.frame.width, height: self.view.frame.height * 0.925))
        return CGSize(width: self.view.frame.width, height: self.view.frame.height * 0.925)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = collection.indexPathsForVisibleItems.first {
            switch indexPath.row {
            case 0:
                circle1.image = UIImage(systemName: "circle.fill")
                circle2.image = UIImage(systemName: "circle")
                circle3.image = UIImage(systemName: "circle")
            case 1:
                circle1.image = UIImage(systemName: "circle")
                circle2.image = UIImage(systemName: "circle.fill")
                circle3.image = UIImage(systemName: "circle")
            default:
                circle1.image = UIImage(systemName: "circle")
                circle2.image = UIImage(systemName: "circle")
                circle3.image = UIImage(systemName: "circle.fill")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.collectionViewLayout.invalidateLayout()
    }


}
