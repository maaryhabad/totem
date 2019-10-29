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
    
    static func save(mensagem: Mensagem) {
        
        let novaMensagem = mensagem
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        var mensagemData: [String: Any] = mensagem.mapToDictionary()
        ref = db.collection("mensagens").addDocument(data: mensagemData) { err in
            if let err = err {
                print("Erro na adição do documento: \(err)")
            } else {
                print("Documento adicionado com  a ID: \(ref!.documentID)")
            }
        }
        
    }
    
    func save(totem: Totem) {
        
    }
    
    func configurarBD() {
        

    }
}

