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
    
    
    //MARK: Usuario
    static func criarUsuario (usuario: Usuario) -> String! {
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
    
    static func retornaUsuario(id: String, comContatos: Bool = true,
                                completionHandler: @escaping ((Usuario)->()) ) {
        let db = Firestore.firestore()
        db.collection("usuarios").whereField(FieldPath.documentID(), isEqualTo: id).getDocuments() { (qs, err) in
            if let err = err {
                print("Erro pegando os usuarios", err)
            } else {
                
                guard let querySnapshot = qs else { return }
                
                guard querySnapshot.documents.count > 0 else  { return }
               

                let usuario = Usuario.mapToObject(usuarioData: querySnapshot.documents[0].data())
                
                if comContatos {
                    Usuario.populaContatos(contatosID: usuario.contatosID) { contatos in
                        usuario.contatos = contatos
                    }
                    DAOFirebase.updateUsuario(id: id, contatosID: usuario.contatosID!)
                }
                
                print("Consegui pegar os usuarios", querySnapshot)
                completionHandler(usuario)
            }
        }
    }
    
    static func updateUsuario(id: String, contatosID: [String]) {
        let db = Firestore.firestore()
        print(contatosID)
        db.collection("usuarios").document(id).updateData([
            "contatos": contatosID
        ]) { err in
            if let err = err {
                print("Erro ao fazer o update do documento", err)
            } else {
                print("Fez upload do update do documento")
            }
        }
        
    }
    
    // MARK: Totem

    static func criarTotem(totem: Totem) -> String! {
        let db = Firestore.firestore()
        var id: String! = nil
        
        var ref: DocumentReference? = nil
        var totemDic: [String:Any] = totem.mapToDictionary()
        ref = db.collection("totem").addDocument(data: totemDic) { err in
            if let err = err {
                print("Erro na adição do documento totem: \(err)")
            } else {
                print("Documento adicionado com a ID: \(ref!.documentID)")
                return id = ref?.documentID
            }
        }
        return id
    }
    
    static func retornaTotem(id: String, completionHandler: @escaping ((Totem) -> ()) ) {
        let db = Firestore.firestore()
        db.collection("totem").whereField(FieldPath.documentID(), isEqualTo: id).getDocuments() { (qs, err) in
            if let err = err {
                print("Erro pegando os totens", err)
            } else {
                guard let querySnapshot = qs else { return }
                guard querySnapshot.documents.count > 0 else { return }
                
                let totem = Totem.mapToObject(totemData: querySnapshot.documents[0].data())
                print("Consegui pegar os totems", querySnapshot)
                completionHandler(totem)
            }
        }
        
    }
    

}

