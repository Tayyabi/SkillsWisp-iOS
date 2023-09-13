//
//  PDFViewWrapper.swift
//  SkillsWisp
//
//  Created by M Tayyab on 13/09/2023.
//

import SwiftUI
import PDFKit

struct PDFViewWrapper: UIViewRepresentable {
    let pdfURL: URL

    func makeUIView(context: Context) -> PDFView {
        
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: pdfURL)
        pdfView.displayMode = .singlePageContinuous // or .continuous
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {}
}

struct PDFViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewWrapper(pdfURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/skillswisp.appspot.com/o/Muhammad_Mobile_Dev_CV.pdf?alt=media&token=8e29db90-9cf4-4d46-a93a-13d03df3b307")!)
    }
}
