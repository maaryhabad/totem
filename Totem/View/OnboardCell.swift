//
//  OnboardCell.swift
//  totem
//
//  Created by Kevin Katzer on 30/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import UIKit

class OnboardCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet weak var start: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
