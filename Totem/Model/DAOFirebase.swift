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
   
    //MARK: Mensagem
    
    var db: Firestore!
    
    // completionHandler: @escaping ([Usuario])->()
    static func criarMensagem (mensagem: Mensagem, completionHandler: @escaping (String) -> ()) {
        
        let db = Firestore.firestore()
        var id: String! = nil
        
        var ref: DocumentReference? = nil
        var mensagemDic: [String: Any] = mensagem.mapToDictionary()
        ref = db.collection("mensagens").addDocument(data: mensagemDic) { err in
            if let err = err {
                //print("Erro na adição do documento mensagens: \(err)")

            } else {
                //print("Mensagem add com a ID: \(ref!.documentID)")
                id = ref?.documentID
                
                if(completionHandler != nil){
                    completionHandler(id)
                }
            }
        }
        //print("Criou msg no firebase")
    }

//    Usuario.populaContatos(contatosID: usuario!.contatosID) { contatos in
//        usuario!.contatos = contatos
//    }
    
    
    

    
    
    //MARK: Usuario
    static func criarUsuario (usuario: Usuario) -> String! {
        let db = Firestore.firestore()
        var id: String! = nil
        
        var ref: DocumentReference? = nil
        var usuarioDic: [String: Any] = usuario.mapToDictionary()
        ref = db.collection("usuarios").addDocument(data: usuarioDic) { err in
            if let err = err  {
                //print("Erro na adição do documento usuários: \(err)")
            } else {
                //print("Documento adicionado com a ID: \(ref!.documentID)")
                return id = ref?.documentID
            }
        }
        return id
    }
    
    
    static func retornaUsuario(userId: String, completion: @escaping ((Usuario)->())) -> Usuario? {
        
        let db = Firestore.firestore()
        var usuario: Usuario?
        db.collection("usuarios").whereField(FieldPath.documentID(), isEqualTo: userId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                guard let querySnapshot = querySnapshot else { return }
                guard querySnapshot.documents.count > 0 else  { return }

                usuario = Usuario.mapToObject(usuarioData: querySnapshot.documents[0].data(), id: querySnapshot.documents[0].documentID)
                
                
                completion(usuario!)
            }
        }
        return usuario
    }
    
    
    
    
    
    
    
    /*
    static func retornaUsuario(id: String, completionHandler: ((Usuario)->())? = nil){
        let db = Firestore.firestore()
        var usuario: Usuario?
        
        db.collection("usuarios").whereField(FieldPath.documentID(), isEqualTo: id).getDocuments() { (qs, err) in
            if let err = err {
                //print("Erro pegando os usuarios", err)
            } else {
                
                guard let querySnapshot = qs else { return }
                guard querySnapshot.documents.count > 0 else  { return }

                usuario = Usuario.mapToObject(usuarioData: querySnapshot.documents[0].data())
                Model.instance.usuario = usuario!
                //print("usuario = \(usuario?.nome)")
                
                if (usuario?.contatosID!.count)! > 0 {
                    Usuario.populaContatos(contatosID: usuario!.contatosID) { contatos in
                        usuario!.contatos = contatos
                        Model.instance.usuario.contatos = contatos
                        //print("usuario_model = \(usuario?.nome)")
                        
                    }
                }
                
                if (completionHandler != nil) {
                    //print("Consegui pegar os usuarios", querySnapshot)
                    //print("entrou no if")
                    completionHandler!(usuario!)
                }
            }
        }
//        //print("Ira para o return")
//        //print(usuario?.nome)
//        return usuario
    }
    */
    
    static func updateUsuario(id: String, contatosID: [String]) {
        let db = Firestore.firestore()
        //print(contatosID)
        db.collection("usuarios").document(id).updateData([
            "contatos": contatosID
        ]) { err in
            if let err = err {
                print("Erro ao fazer o update do documento", err)
            } else {
//                print("Fez upload do update do documento")
            }
        }
        
    }
    
    // MARK: Totem

    static func criarTotem(totem: Totem) -> String {
        let db = Firestore.firestore()
        var id: String! = nil
        
        var ref: DocumentReference? = nil
        let totemDic: [String:Any] = totem.mapToDictionary()
        ref = db.collection("totem").addDocument(data: totemDic) { err in
            if let err = err {
                print("Erro na adição do documento totem: \(err)")
            } else {
                //print("Documento adicionado com a ID: \(ref!.documentID)")
                return id = ref?.documentID
            }
        }
        return id
    }
    
    static func retornaTotens(idCriador :String, completion: @escaping (([Totem])->())) -> [Totem]!{
        let db = Firestore.firestore()
        var totens: [Totem]! = []
        
        db.collection("totem").whereField("idCriador", isEqualTo: idCriador).getDocuments() { (QuerySnapshot, err) in
            if let err = err {
                print("Erro em retornaTotens", err)
            } else {
                for document in QuerySnapshot!.documents {
                    let totem = Totem.mapToObject(totemData: document.data(), id: document.documentID)
                    totens.append(totem)
                }
            }
            completion(totens)
        }
        return totens
    }
    
    static func buscarMensagens(id: String, completion: @escaping (([Mensagem])->())) -> [Mensagem] {
        let db = Firestore.firestore()
        var mensagens: [Mensagem] = []
        
        db.collection("mensagens").whereField("para", isEqualTo: id).getDocuments() { (qs, err) in
            if err != nil {
                print("Erro na busca pelo totem", err!)
            } else {
                for document in qs!.documents {
                    let mensagem = Mensagem.mapToObject(mensagemData: document.data(), id: document.documentID)
                    mensagens.append(mensagem)
                }
            }
//            print("buscarMensagens -> Total msgs: \(mensagens.count)")
            completion(mensagens)
        }
        return mensagens
        
    }
    
    static func buscarTotem(idPossuinte :String, idCriador :String, completion: @escaping ((String)->())) -> String{
        let db = Firestore.firestore()
        var totemId :String = ""
        
        db.collection("totem").whereField("idPossuinte", isEqualTo: idPossuinte).getDocuments() { (qs, err) in
            if err != nil {
                //print("Erro na busca pelo totem", err)
            } else {
                for document in qs!.documents {
                    let totemIdcriador = ("\(document.data()["idCriador"] ?? "")")
                    if(totemIdcriador == idCriador){
                        totemId = ("\(document.documentID)")
                    }
                }
            
            }
            completion(totemId)
        }
        
        return totemId
    }
    
    static func updateTotemMensagens(totem: Totem) {
        let db = Firestore.firestore()
        
        db.collection("totem").document(totem.id!).updateData([
            "mensagens" : totem.mensagens!
               ]) { err in
                   if let err = err {
                       print("Erro ao fazer o update do documento", err)
                   } else {
//                       print("Fez upload do update do documento")
                   }
               }
    
       }
    
    //MARK: Listeners
    
//    func listenerContatos() {
//        let db = Firestore.firestore()
//
//        db.collection("usuario").document(Model.instance.usuario.id!).addSnapshotListener { documentSnapshot, error in
//            guard let document = documentSnapshot else {
//                //print("Erro no listener do usuário: \(error!)")
//                return
//            }
//            let source = document.metadata.hasPendingWrites ? "Local" : "Server"
//            //print("\(source) data: \(document.data() ?? [:])")
//        }
//    }
    
    static func realTimeTotem(id: String, completion: @escaping ((Totem)->())) -> Totem!{
        let db = Firestore.firestore()
        var totem: Totem?
        
        db.collection("totem").whereField(FieldPath.documentID(), isEqualTo: id).addSnapshotListener({(qs, err) in
            if let err = err {
                print("Erro pegando os usuarios", err)
            } else {
                guard let querySnapshot = qs else { return }
                guard querySnapshot.documents.count > 0 else  { return }

                totem = Totem.mapToObject(totemData: querySnapshot.documents[0].data(), id: querySnapshot.documents[0].documentID)
                print("Atualizou totem \(String(describing: totem?.nome))")
            }
            completion(totem!)
        })
        return totem
    }
    
//    func listenerMensagens() {
//        let db = Firestore.firestore()
//
//        db.collection("totem").whereField(FieldPath.documentID(), isEqualTo: userId).addSnapshotListener { querySnapshot, error in
//            guard let snapshot = querySnapshot else {
//                //print("Erro: \(error)")
//                return
//            }
//            snapshot.documentChanges.forEach { diff in
//                if (diff.type == .added) {
//                    //print("Nova mensagem: \(diff.document.data())")
//                }
//                if (diff.type == .modified) {
//                    //print("Mensagem modificada: \(diff.document.data())")
//                }
//                if (diff.type == .removed) {
//                    //print("Mensagem removida: \(diff.document.data())")
//                }
//            }
//        }
//    }
}

