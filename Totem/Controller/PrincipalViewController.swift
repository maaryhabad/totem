//
//  PrincipalViewController.swift
//  totem
//
//  Created by José Guilherme Bestel on 29/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI
import FirebaseStorage
import Firebase

class PrincipalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var contaInfosView: UIView!
    @IBOutlet var contaView: UIView!
    @IBOutlet var bgView: UIView!
    @IBOutlet var humorTituloView: UIView!
    @IBOutlet var humoresView: UIView!
    @IBOutlet var detalhesView: UIView!
    
    @IBOutlet var felizView: UIView!
    @IBOutlet var confianteView: UIView!
    @IBOutlet var tranquiloView: UIView!
    @IBOutlet var cansadoView: UIView!
    @IBOutlet var irritadoView: UIView!
    
    @IBOutlet var felizImg: UIImageView!
    @IBOutlet var confianteImg: UIImageView!
    @IBOutlet var tranquiloImg: UIImageView!
    @IBOutlet var cansadoImg: UIImageView!
    @IBOutlet var irritadoImg: UIImageView!
    
    //Card conta
    @IBOutlet var nomeLabelConta: UILabel!
    @IBOutlet var iconeTotemConta: UIImageView!
    
    //Card detalhe contato
    @IBOutlet var nomeContatoLabel: UILabel!
    @IBOutlet var imageContato: UIImageView!
    
    //Vars p/ view Record
    @IBOutlet var record: UIView!
    @IBOutlet var recordButton: UIImageView!
    @IBOutlet var recordHeight: NSLayoutConstraint!
    @IBOutlet var audioInputPlot: UIView!
    @IBOutlet var audioLabelView: UIView!
    @IBOutlet var audioLabel: UILabel!
    var displayLink :CADisplayLink! = nil
    
    //Load Indicator
    @IBOutlet var loadInicatorView: UIView!
    @IBOutlet var loadIndicator: UIActivityIndicatorView!
    
    //Var para audio
    var micMixer: AKMixer!
    var recorder: AKNodeRecorder!
    var player: AKAudioPlayer!
    var tape: AKAudioFile!
    var micBooster: AKBooster!
    var mainMixer: AKMixer!
    var plot: AKNodeOutputPlot?
    let mic = AKMicrophone()
    var running: state = .ready
    var skippedTo: Double = 0.0
    
    var audioFileName: URL!
    var urlAudio: URL!
    
    @IBOutlet var contaInfoView: GradientView!
    
    var emocoesView :[UIView] = []
    var emocoesImg :[UIImageView?] = []
    
    var selectIndexUsuario = -1
    var selectIndexMsg = -1
    var selectIndexEmocao = -1
    var cardContaIsOpen = Bool(true)
    
    var mensagensUsuario :[MensagemDomain]! = []
    var contatosDomain :[ContatoDomain]! = []
    
    @IBOutlet var table: UITableView!{
        didSet{
            let nibName = UINib(nibName: "ContatoTVCell", bundle: nil)
            table.register(nibName, forCellReuseIdentifier: "contatoCell")
            table.dataSource = self
            table.allowsSelection = true
            table.delegate = self
        }
        
    }
    @IBOutlet var tableMensagens: UITableView!{
        didSet{
            let nibName = UINib(nibName: "MensagemTVCell", bundle: nil)
            tableMensagens.register(nibName, forCellReuseIdentifier: "mensagemCell")
            tableMensagens.dataSource = self
            tableMensagens.allowsSelection = true
            tableMensagens.delegate = self
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        AKAudioFile.cleanTempDirectory()
        
        AKSettings.bufferLength = .medium
        
        do {
            try AKSettings.setSession(category: .playAndRecord, with: .allowBluetoothA2DP)
        } catch {
            AKLog("Could not set session category.")
        }

        AKSettings.defaultToSpeaker = true
        
        let monoToStereo = AKStereoFieldLimiter(mic, amount: 1)
        micMixer = AKMixer(monoToStereo)
        micBooster = AKBooster(micMixer)

        // Will set the level of microphone monitoring
        micBooster.gain = 0
        recorder = try? AKNodeRecorder(node: micMixer)
        if let file = recorder.audioFile {
            do {
                try player = AKAudioPlayer(file: file)
            } catch {
                AKLog("Error on file loading")
            }
        }
        player.looping = false
//        player.completionHandler = onPlayFinish

        mainMixer = AKMixer(player, micBooster)

        AudioKit.output = mainMixer
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Large title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //Left Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "+", style: .done, target: self, action: #selector(self.action(sender:)))
        
        //Shadow in card
        contaInfosView.layer.applySketchShadow(color: UIColor.black, alpha: Float(0.09), x: CGFloat(2.0), y: CGFloat(2.0), blur: CGFloat(10.0), spread: CGFloat(0.0))
        
        //View conta
        self.popularCardConta()
        
        //View loadIndicator
        self.loadInicatorView.isHidden = true
        
        //View de mensagens oculta
        detalhesView.isHidden = true
        
        //View Record
        record.isHidden = true
        
        //Emoções
        self.emocoesImg = [self.felizImg, self.confianteImg, self.tranquiloImg, self.cansadoImg, self.irritadoImg]
        self.emocoesView = [self.felizView, self.confianteView, self.tranquiloView, self.cansadoView, self.irritadoView]
        
        //Gesture emocoes
        felizView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("someAction:"))))
        confianteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("someAction:"))))
        tranquiloView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("someAction:"))))
        cansadoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("someAction:"))))
        irritadoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("someAction:"))))
        
        //Gravação do audio
        record.layer.cornerRadius = 25
        recordButton.image = UIImage(named: "BtnGravar")
//        playerSlider.isContinuous = false
        setupPlot()
        
        //Dados de contatos
        self.contatosDomain = Model.instance.contatos
        
        
        let config = UIImage.SymbolConfiguration(scale: .small)
        let thumb = UIImage(systemName: "circle.fill")?.withConfiguration(config).withTintColor(.lightGray, renderingMode: .alwaysOriginal)
//        playerSlider.setThumbImage(thumb, for: .normal)
    }
    
    //Função para click numa emoção
    @objc func someAction(_ sender: UITapGestureRecognizer){
        
        let nmView = sender.view?.restorationIdentifier
        var selectedView :Int = -1
        
        if(nmView == "Feliz"){
            selectedView = 0
        }else if(nmView ==  "Confiante"){
            selectedView = 1
        }else if(nmView ==  "Tranquilo"){
            selectedView = 2
        }else if(nmView ==  "Cansado"){
            selectedView = 3
        }else if(nmView ==  "Irritado"){
            selectedView = 4
        }
        
        
        if(selectedView == self.selectIndexEmocao){
            self.selectIndexEmocao = -1
            self.mudarCardConta(selectedView: -1)
            
        }else{
            self.selectIndexEmocao = selectedView
            self.mudarCardConta(selectedView: selectedView)
        }
    }
    
    func mudarCardConta(selectedView :Int){
        //Foreach nos icons e deixar preto apenas o selecionado
        for index in 0..<self.emocoesView.count{
            let view = self.emocoesView[index]
            let identifier = view.restorationIdentifier
            
            let imgView = self.emocoesImg[index]
            
            if(index == selectedView){
                imgView!.image = UIImage(named: "\(identifier!)Selecionado")
            }else{
                imgView!.image = UIImage(named: identifier!)
            }
        }
        
        switch selectedView {
        case 0:
            self.contaInfoView.changeColors(x: #colorLiteral(red: 0.9930667281, green: 0.9711793065, blue: 0, alpha: 1), y: #colorLiteral(red: 0.8069227141, green: 0.605541353, blue: 0.001397269817, alpha: 1))
            self.mudarSentimento(sentimento: "feliz")
        case 1:
            self.contaInfoView.changeColors(x: #colorLiteral(red: 0.2394615939, green: 0.5985017667, blue: 1, alpha: 1), y: #colorLiteral(red: 0.2802936715, green: 0.3074454975, blue: 0.7883472621, alpha: 1))
            self.mudarSentimento(sentimento: "confiante")
        case 2:
            self.contaInfoView.changeColors(x: #colorLiteral(red: 0.2432119415, green: 1, blue: 0.349971955, alpha: 1), y: #colorLiteral(red: 0.1078010393, green: 0.7889236992, blue: 0, alpha: 1))
            self.mudarSentimento(sentimento: "tranquilo")
        case 3:
            self.contaInfoView.changeColors(x: #colorLiteral(red: 0.7977316976, green: 0.3991055914, blue: 0.6926496238, alpha: 1), y: #colorLiteral(red: 0.5898076296, green: 0.2702057064, blue: 0.6506463289, alpha: 1))
            self.mudarSentimento(sentimento: "cansado")
        case 4:
            self.contaInfoView.changeColors(x: #colorLiteral(red: 0.9810246825, green: 0.5891146064, blue: 0.2307883501, alpha: 1), y: #colorLiteral(red: 0.9276855588, green: 0.2729465365, blue: 0.3393034637, alpha: 1))
            self.mudarSentimento(sentimento: "irritado")
        default:
            self.contaInfoView.changeColors(x: UIColor.white, y: UIColor.white)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //print("numberOfSections -> \(String(describing: tableView.restorationIdentifier))")
        if(tableView.restorationIdentifier == "tableGravacoes"){
            return 1
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView.restorationIdentifier == "tableGravacoes"){
            if(self.selectIndexUsuario != -1){
                self.mensagensUsuario =  self.contatosDomain[self.selectIndexUsuario].mensagens
                print("qtde de mensagens: \(self.mensagensUsuario.count)")
                return self.mensagensUsuario.count
            }
            return 0
        }
        return self.contatosDomain.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("cellForRowAt -> \(String(describing: tableView.restorationIdentifier))")
        if(tableView.restorationIdentifier == "tableGravacoes"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "mensagemCell", for: indexPath) as! MensagemTVCell
            let mensagem = self.mensagensUsuario[indexPath.row]
            
            cell.nomeLabel.text = mensagem.primeiroNome
            cell.dataLabel.text = mensagem.dataEnvio
            cell.tempoLabel.text = mensagem.duracaoAudio
            if(mensagem.isVisualizado){
                cell.isRead()
            }else{
                cell.isNew()
            }
            
            cell.mensagemURL = mensagem.url
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contatoCell", for: indexPath) as! ContatoTVCell
        let contato = self.contatosDomain[indexPath.row]
        
        cell.nome.text = contato.nome
        cell.imagem.image = UIImage(named: contato.imagem)
        cell.totemIcon.image = UIImage(named: contato.flagTotemImg)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("didSelectRowAt -> \(String(describing: tableView.restorationIdentifier))")
        
        if(tableView.restorationIdentifier == "tableGravacoes"){
            let cell = tableView.cellForRow(at: indexPath) as! MensagemTVCell
            
            if( self.selectIndexMsg != indexPath.row){
                self.selectIndexMsg = indexPath.row
                cell.detalhesGravacaoView.isHidden = false
            }else{
                self.selectIndexMsg = -1
                cell.detalhesGravacaoView.isHidden = true
            }
            
            let _ = self.tableView(tableView, heightForRowAt: indexPath)
            tableView.beginUpdates()
            tableView.endUpdates()
        }else{
            self.selectIndexUsuario = indexPath.row
            let contatoDomain = self.contatosDomain[self.selectIndexUsuario]
            self.mensagensUsuario =  contatoDomain.mensagens
            self.nomeContatoLabel.text = contatoDomain.nome
            self.imageContato.image = UIImage(named: contatoDomain.imagem)
            self.tableMensagens.reloadData()
            self.openCloseContaView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView.restorationIdentifier == "tableGravacoes"){
            if(selectIndexMsg == indexPath.row){
                return 150.0
            }else{
                if(selectIndexMsg != -1){
                    if tableView.cellForRow(at: indexPath) is MensagemTVCell{
                        let cell = tableView.cellForRow(at: indexPath) as! MensagemTVCell
                        cell.detalhesGravacaoView.isHidden = true
                    }
                    
                }
                return 55.0
            }
        }
        
        return 80.0
    }
    
    
    //Definir para qual tela irá no +
    //TODO: Fazer uma  segue@objc
    @objc func action(sender: UIBarButtonItem) {
        //print("hjxdbsdhjbv")
    }
    
    func fadeAnimationView(view :UIView, isHidden :Bool){
        UIView.animate(withDuration: 0.33, animations: {
            if(isHidden){
                view.alpha = 0.0
            }else{
                view.alpha = 1.0
            }
            view.isHidden = isHidden
        })
    }
    
    @IBAction func returnContatos(_ sender: Any) {
        if(selectIndexMsg != -1){
            self.selectIndexMsg = -1
            self.tableView(self.tableMensagens, heightForRowAt: self.tableMensagens.indexPathForSelectedRow!)
            let cell = self.tableMensagens.cellForRow(at: self.tableMensagens.indexPathForSelectedRow!) as! MensagemTVCell
            cell.detalhesGravacaoView.isHidden = true
            self.tableMensagens.beginUpdates()
            self.tableMensagens.endUpdates()
        }
        self.openCloseContaView()
    }
    
    
    func openCloseContaView() {

        var multi :CGFloat
        var alpha :CGFloat
        var flagHidden :Bool
        
        //Identificar a constraint correta e aplicar a alternância da porcentagem
        for constr in bgView.constraints{
            if(constr.identifier == "propHeightContaView"){
                if constr.multiplier > CGFloat(0.40){
                    multi = CGFloat(0.27)
                    alpha = 0.0
                    flagHidden = true
                    self.cardContaIsOpen = false
                }else{
                    multi = CGFloat(0.45)
                    alpha = 1.0
                    flagHidden = false
                    self.cardContaIsOpen = true
                }
                
                if(flagHidden){
                    //1 humor dps contaView
                    self.efectHumor(alpha: alpha, flagHidden: flagHidden, multi: multi, constr :constr)
//                    detalhesView.isHidden = false
                    self.fadeAnimationView(view: detalhesView, isHidden: false)
                    table.isHidden = true
                    record.isHidden = false
                }else{
                    //1 contaView dps humor
                    self.efectContaView(alpha: alpha, flagHidden: flagHidden, multi: multi, constr :constr)
//                    detalhesView.isHidden = true
                    self.fadeAnimationView(view: detalhesView, isHidden: true)
                    table.isHidden = false
                    record.isHidden = true
                }
            }
        }
    }
    

    func efectHumor(alpha :CGFloat, flagHidden :Bool, multi  :CGFloat, constr :NSLayoutConstraint){
        UIView.animate(withDuration: 0.2,
                        delay: 0.0,
                        options: .curveEaseIn,
                        animations: {
                            if(flagHidden){
                                self.efectContaView(alpha: alpha, flagHidden: flagHidden, multi: multi, constr :constr)
                            }
                            
                            self.humorTituloView.alpha = alpha
                            self.humoresView.alpha = alpha
        }, completion: {(finished:Bool) in
        
        })
    }
    
    func efectContaView(alpha :CGFloat, flagHidden :Bool, multi  :CGFloat, constr :NSLayoutConstraint){
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: {
                         let newConstraint = constr.constraintWithMultiplier(multi)
                        newConstraint.identifier = constr.identifier
                        self.bgView.removeConstraint(constr)
                        self.bgView.addConstraint(newConstraint)
                        
                        self.bgView.layoutIfNeeded()
        }, completion: {(finished:Bool) in
            if(!flagHidden){
                self.efectHumor(alpha: alpha, flagHidden: flagHidden, multi: multi, constr :constr)
            }
        })
    }
    
    
    // ------------------------------------------------------------------------------------------------------
    // MARK: BOTTOM SHEET RECORD
    // ------------------------------------------------------------------------------------------------------
    
    @IBAction func recordButtonTap(_ sender: Any) {
        if (running == .ready) {
            recordButton.image = UIImage(named: "BtnStop")
            self.view.layoutIfNeeded()
            self.recordHeight.constant = 250
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            
            if AKSettings.headPhonesPlugged {
                micBooster.gain = 1
            }
            
            micMixer.outputNode.removeTap(onBus: 0)
            
            //Gravar audio
            do {
                try recorder.record()
            } catch { AKLog("Errored recording.") }
            
            running = .recording
            audioInputPlot.isHidden = false
            
        } else if (running == .recording) {
            self.audioLabel.isHidden = false
            recordButton.image = UIImage(named: "BtnEnviar")
            audioInputPlot.isHidden = true
            audioLabelView.isHidden = false
            
            micBooster.gain = 0
            tape = recorder.audioFile!
            
            //Carregar audio
            do {
                try player.replace(file: tape)
            } catch {
                AKLog("Error on audio loading")
            }
            
            let duration = player.audioFile.duration
            recorder.stop()
            audioLabel.text = String(Int(duration/60)) + ":" + String(format: "%02d", Int(duration.truncatingRemainder(dividingBy: 60)))
            
            tape.exportAsynchronously(name: "tmp.m4a", baseDir: .documents, exportFormat: .m4a) {data, exportError in
                if let error = exportError {
                    AKLog("Export Failed \(error)")
                } else {
                    AKLog("Export succeeded")
                    var options = AKConverter.Options()
                    options.bitRate = 16_000
                    options.format = "wav"
                    let tmpURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("file.wav") as URL
                    let converter = AKConverter(inputURL: data!.url, outputURL: tmpURL, options: options)
                    converter.start(completionHandler: { error in
                        if let error = error {
                            AKLog("Erro na conversão:\(error)")
                        } else {
                            self.audioFileName = tmpURL
                        }
                    })
                }
            }
            running = .recorded
        } else if (running == .recorded) {
            //Inicia load
            self.loadInicatorView.isHidden = false
            self.loadIndicator.startAnimating()
            
            let duration = player.audioFile.duration
                let result = Utils.pegarDataAtual()
            
               //Referência ao Storage
                let fileId = result + ".wav"
                let storage = Storage.storage()
                
                //Referência ao Storage
                let storageRef = storage.reference()
                
                //Referência ao arquivo que eu vou fazer o upload
                let archiveRef = storageRef.child(fileId)
                //print("primeiro")
                let uploadTask = archiveRef.putFile(from: audioFileName, metadata: nil) { metadata, error in

                    if let error = error {
                        //print("deu ruim de novo na metadata", error)
                        return
                    } else {
                        //MARK: Salvar no Firebase a nova mensagem
                        //MARK: para: contatoDomain.id
                        //print("segundo")
                        
                        archiveRef.downloadURL(completion: {(url, error) in
                            self.urlAudio = url

                            let tempo = Mensagem.pegarDuracao(resource: self.audioFileName, filePath: fileId)
//                            //print(tempo)

                            //MARK: Pegar como parâmetro esse id
                            let totemId = Model.instance.contatos[self.selectIndexUsuario].totemIDUsuario
//
                            let usr = Model.instance.usuario
                            let dtEnvio = Utils.getDateString(date: result)
                            
                            let novaMensagem = Mensagem(url: self.urlAudio.absoluteString, audio: fileId, datadeEnvio: dtEnvio, duracao: tempo, de: usr.id!, deNome: usr.nome!, para: totemId, salvo: false, visualizado: false)

                            DAOFirebase.criarMensagem(mensagem: novaMensagem){id in
//                                //STOP LOAD
                                novaMensagem.id = id
                                
                                let totem = Model.instance.getTotem(id: totemId)
                                //print("Id totem:  \(String(describing: totem?.id))")
                                //print("Mensagem id: \(novaMensagem.id)")
                                totem!.inserirMensagem(mensagem: novaMensagem)
                                print("Mensagem salva com sucesso.")
                                //MARK: Voltar bottomSheet na posição .ready
                                //MARK: Atualizar tableMensagens
                            }
                            //START LOAD
                            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (Timer) in
                                self.recordHeight.constant = 150
                                self.recordButton.image = UIImage(named: "BtnGravar")
                                self.recordButton.isHidden = false
                                self.audioLabel.isHidden = true
                                self.tableMensagens.reloadData()
                                UIView.animate(withDuration: 0.5, animations: {
                                    self.view.layoutIfNeeded()
                                })
                                self.running = .ready
                                self.loadIndicator.stopAnimating()
                                self.loadInicatorView.isHidden = true
                            }
                            
                        })
                    }
                }
        }
    }
    
    func setupPlot() {
        plot = AKNodeOutputPlot(mic, frame: audioInputPlot.bounds)
        plot?.plotType = .buffer
        plot?.shouldFill = true
        plot?.shouldMirror = true
        plot?.color = .white
        plot?.backgroundColor = .clear
        audioInputPlot.addSubview(plot!)
    }
    
    func popularCardConta(){
        self.nomeLabelConta.text = Model.instance.usuario.nome
        self.iconeTotemConta.image = UIImage(named: Model.instance.usuario.iconeTotem!)
    }
    
    func mudarSentimento(sentimento :String){
        for totem in Model.instance.totens{
            totem.mudarSentimento(sentimento: sentimento)
        }
    }
}
