//
//  MensagemTVCell.swift
//  totem
//
//  Created by José Guilherme Bestel on 01/11/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import UIKit

class MensagemTVCell: UITableViewCell {

    @IBOutlet var nomeLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var tempoLabel: UILabel!
    @IBOutlet var flagMsgNova: UIView!
    @IBOutlet var detalhesGravacaoView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detalhesGravacaoView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func isNew(){
        flagMsgNova.alpha =  1.0
    }
    
    func isRead(){
        flagMsgNova.alpha = 0.0
    }
    
}
