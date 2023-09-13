//
//  DateSheetView.swift
//  SkillsWisp
//
//  Created by M Tayyab on 08/09/2023.
//

import SwiftUI

class PassPaper: ObservableObject {
    @Published var paper: PastSubjectModel?
}

struct PastPaperDateSheetView: View {
    
    @ObservedObject var paper: PassPaper
    
    //@StateObject var vm = PastPaperDateSheetViewModel()
    
    var body: some View {
        
        
        VStack {
            
            ZStack(alignment: .bottomTrailing) {
                
                Color.gray.opacity(0.1)
                
                if (paper.paper?.type == "picture") {
                    RemoteImage(url:  URL(string: paper.paper?.url ?? ""),placeholder: Image("bn_date_sheet"))
                        .aspectRatio(contentMode: .fill)
                }
                else {
                    PDFViewWrapper(pdfURL: URL(string: paper.paper?.url ?? "https://firebasestorage.googleapis.com/v0/b/skillswisp.appspot.com/o/Muhammad_Mobile_Dev_CV.pdf?alt=media&token=8e29db90-9cf4-4d46-a93a-13d03df3b307")!)
                }
                
            }
            
            HStack {
                Spacer()
                Button(action: {
                    
                    
                    
                }, label: {
                    
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle().foregroundColor(.white))
                })
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    
                    Image(systemName: true ? "bookmark.fill": "bookmark")
                        .foregroundColor(true ? .red: .black)
                        .padding()
                        .background(Circle().foregroundColor(.white))
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    
                    Image(systemName: "arrowshape.turn.up.forward")
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle().foregroundColor(.white))
                })
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
        }
        .onAppear{
            
        }
        .navigationTitle("Date Sheet")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct DateSheetView_Previews: PreviewProvider {
    static var previews: some View {
        PastPaperDateSheetView(paper: PassPaper())
    }
}
