//
//  Coders.swift
//  SkillsWisp
//
//  Created by M Tayyab on 13/08/2023.
//

import Foundation
import Firebase

struct Coders {
    
    static let encoder: Firestore.Encoder = {
        
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    static let decoder: Firestore.Decoder = {
        
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
