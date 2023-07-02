//
//  Classes.swift
//  SkillsWisp
//
//  Created by M Tayyab on 24/05/2023.
//

import Foundation
struct Notes: Identifiable, Hashable  {
    
    let id: String = UUID().uuidString
    let name: String
    let background: String
}
