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
    
    @State var isDateSheet = true
    @State var pastPaperId : String?
    
    @StateObject var vm = PastPaperDateSheetViewModel()
    
    var body: some View {
        
        
        VStack {
            
            ZStack(alignment: .center) {
                
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
                    guard let paper = paper.paper else {
                        return
                    }
                    //vm.isLoading = true
                    Task {
                        await vm.downloadDateSheetPastPaper(paper: paper, isDateSheet: isDateSheet)
                    }
                }, label: {
                    
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(.black)
                        .padding()
                        .background(Circle().foregroundColor(.white))
                })
                
                Spacer()
                
                Button(action: {
                    guard let id = paper.paper?.id,
                          !vm.isBookmark else {
                        return
                    }
                    vm.isBookmark = true
                    Task {
                        if (isDateSheet) {
                            await vm.addBookmark(dateSheetId:id, isBookmark:true)
                        }
                        else {
                            guard let pastPaperId = pastPaperId else { return }
                            await vm.addBookmarkPastPaper(pastPaperId: pastPaperId, subjectId: id, isBookmark: true)
                        }
                    }
                }, label: {
                    
                    Image(systemName: vm.isBookmark ? "bookmark.fill": "bookmark")
                        .foregroundColor(vm.isBookmark ? .red: .black)
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
            
            print("isDateSheet: \(isDateSheet)")
            
            guard let id = paper.paper?.id else {
                return
            }
            Task {
                //vm.fetchNoteById(id: dataStore.note_id ?? "")
                if (isDateSheet) {
                    await vm.isBookmarked(dateSheetId: id)
                }
                else {
                    await vm.isBookmarkedPastPaper(subjectId: id)
                }
            }
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
