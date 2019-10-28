//
//  DAOFirebase.swift
//  totem
//
//  Created by Mariana Beilune Abad on 28/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class DAOFirebase {
    
    var db: Firestore!
    
    func save(mensagem: Mensagem) {
        
        let novaMensagem = mensagem
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        
    }
    
    func save(totem: Totem) {
        
    }
    
    func configurarBD() {
        

    }
}

