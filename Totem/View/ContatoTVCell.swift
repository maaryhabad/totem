//
//  ContatoTVCell.swift
//  totem
//
//  Created by José Guilherme Bestel on 29/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import UIKit

class ContatoTVCell: UITableViewCell {

    @IBOutlet var nome: UILabel!
    @IBOutlet var imagem: UIImageView!
    @IBOutlet var totemIcon: UIImageView!
    @IBOutlet var bgView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        bgView.layer.applySketchShadow(color: UIColor.black, alpha: Float(0.09), x: CGFloat(2.0), y: CGFloat(2.0), blur: CGFloat(10.0), spread: CGFloat(0.0))
        

        // Configure the view for the selected state
    }
    
}
