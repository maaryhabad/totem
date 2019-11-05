//
//  BottomSheetController.swift
//  totem
//
//  Created by Kevin Katzer on 01/11/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import UIKit

class BottomSheetController: UIViewController {
    @IBOutlet var record: UIView!
    
    var border = UIBezierPath()
    
    var borderSquare = UIBezierPath()

    var circle = UIBezierPath()
    
    var square = UIBezierPath()
    
    let borderLayer = CAShapeLayer()
    let circleLayer = CAShapeLayer()
    
    @IBOutlet weak var recordHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        record.layer.cornerRadius = 25
        
        let center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height - 75)
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.rotated(by: -CGFloat(Double.pi/2 + Double.pi/4))
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        border = UIBezierPath(ovalIn: CGRect(x: ((view.frame.size.width / 2) - 30.0), y: view.frame.size.height - 105, width: 60, height: 60))
        border.close()
//        border.apply(transform)
        circle = UIBezierPath(ovalIn: CGRect(x: ((view.frame.size.width / 2) - 25.0), y: view.frame.size.height - 100, width: 50, height: 50))
        circle.close()
        
//        circle.apply(transform)
        
        square = UIBezierPath(roundedRect: CGRect(x: ((view.frame.size.width / 2) - 17.5), y: view.frame.size.height - 92.5, width: 35, height: 35), cornerRadius: 5)
        square.close()
        
        
        borderLayer.path = border.cgPath
        borderLayer.fillColor = #colorLiteral(red: 0.9598520398, green: 0, blue: 0.3081979156, alpha: 0)
        borderLayer.strokeColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        borderLayer.lineWidth = 3
        

        
        circleLayer.path = circle.cgPath
        circleLayer.fillColor = #colorLiteral(red: 0.9598520398, green: 0, blue: 0.3081979156, alpha: 1)
        circleLayer.lineWidth = 0
        
        view.layer.addSublayer(borderLayer)
        view.layer.addSublayer(circleLayer)
    }
    
    func animate() {
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.5
        animation.fromValue = circleLayer.path
        animation.toValue = square.cgPath
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: "easeInEaseOut"))
        
        
        circleLayer.add(animation, forKey: "path")
        circleLayer.path = square.cgPath
        
        self.view.layoutIfNeeded()
        self.recordHeight.constant = 250
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            if (circle.contains(t.location(in: self.view))) {
                animate()
            }
        }
        
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
