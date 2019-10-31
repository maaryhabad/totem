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
    //CRUD **
    
    var db: Firestore!
    
    static func criarMensagem (mensagem: Mensagem) -> String! {
        
        let db = Firestore.firestore()
        var id: String! = nil
        
        var ref: DocumentReference? = nil
        var mensagemDic: [String: Any] = mensagem.mapToDictionary()
        ref = db.collection("mensagens").addDocument(data: mensagemDic) { err in
            if let err = err {
                print("Erro na adição do documento mensagens: \(err)")

            } else {
                print("Documento adicionado com  a ID: \(ref!.documentID)")
                id = ref?.documentID
            }
        }
        return id
    }
    
    func lerMensagem () {
        
    }
    
    static func criarUsuario (usuario: Usuario) -> String!{
        let db = Firestore.firestore()
        var id: String! = nil
        
        var ref: DocumentReference? = nil
        var usuarioDic: [String: Any] = usuario.mapToDictionary()
        ref = db.collection("usuarios").addDocument(data: usuarioDic) { err in
            if let err = err  {
                print("Erro na adição do documento usuários: \(err)")
            } else {
                print("Documento adicionado com a ID: \(ref!.documentID)")
                return id = ref?.documentID
            }
        }
        return id
    }
    
    func save(totem: Totem) {
        
    }
    
    func configurarBD() {
        

    }
}

