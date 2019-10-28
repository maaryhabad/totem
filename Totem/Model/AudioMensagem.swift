//
//  Audio.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 23/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation
import CloudKit

class AudioMensagem {
    var audio: URL
    var id: String
    
    init(audio: URL, id: String) {
        self.audio = audio
        self.id = id
    }
    
}
