//
//  NotesScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 11/06/2023.
//

import SwiftUI
import PDFKit


struct NotesView: View {
    
    //let pdfURL = Bundle.main.url(forResource: "example", withExtension: "pdf")!
    @ObservedObject var dataStore: DataStore
    @StateObject var vm = NotesViewModel()
    @State var shouldNavigate = false
    
    @State var showView: Bool = false
    
    var body: some View {
        
        
        
        
        ZStack(alignment: .bottom) {
            
            
            VStack {
                
                ZStack(alignment: .bottomTrailing) {
                    
                    Color.gray.opacity(0.1)
                    PDFViewWrapper(pdfURL: URL(string: "https://d1.islamhouse.com/data/en/ih_books/single/en_Sahih_Al-Bukhari.pdf")!)
                                .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack{
                        
                        Button(action: {}, label: {
                            
                            Image(systemName: "hand.thumbsup")
                                .foregroundColor(.black)
                                .padding()
                                .background(Circle().foregroundColor(.white))
                        })
                        Text("\(vm.savedEntity?.likes_count ?? 0)")
                            .font(.system(size: 14))
                        
                        Button(action: {
                            
                            showView.toggle()
                            
                        }, label: {
                            
                            Image(systemName: "message")
                                .foregroundColor(.black)
                                .padding()
                                .background(Circle().foregroundColor(.white))
                        })
                        .popover(isPresented: $showView) {
                            ReviewsView()
                        }
                        Text("1.5k")
                            .font(.system(size: 14))
                        
                    }
                    .padding()
                    
                }
                
                HStack {
                    Spacer()
                    Button(action: {}, label: {
                        
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.black)
                            .padding()
                            .background(Circle().foregroundColor(.white))
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: vm.savedEntity!.bookmark ? "bookmark.fill": "bookmark")
                            .foregroundColor(vm.savedEntity!.bookmark ? .red: .black)
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
            
            
        }
        .onAppear{
            vm.fetchNoteById(id: dataStore.id)
        }
        .navigationTitle("Notes")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

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

struct NotesScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(dataStore: DataStore())
    }
}
