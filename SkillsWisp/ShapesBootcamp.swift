//
//  ShapesBootcamp.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/05/2023.
//

import SwiftUI

struct ShapesBootcamp: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
        //Rectangle()
        //Capsule(style: .continuous)
        //Ellipse()
        //Circle()
            //.fill(Color.green)
            //.foregroundColor(.pink)
            //.stroke()
            //.stroke(Color.red, lineWidth: 20)
            //.stroke(Color.orange, style: StrokeStyle(lineWidth: 20, lineCap: .round, dash: [30]))
            .trim(from: 0.4,to: 1.0)
            //.stroke(Color.purple, lineWidth: 50)
            .frame(width: 300, height: 200)
        
    }
}

struct ShapesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ShapesBootcamp()
    }
}
