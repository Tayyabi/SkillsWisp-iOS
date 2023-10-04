//
//  NotesScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 11/06/2023.
//

import SwiftUI


struct NotesView: View {
    
    //let pdfURL = Bundle.main.url(forResource: "example", withExtension: "pdf")!
    @ObservedObject var dataStore: StandSubjNoteDataStore
    @StateObject var vm = NotesViewModel()
    @State var shouldNavigate = false
    
    @State var showView: Bool = false
    
    var body: some View {
        
        
        
        ZStack(alignment: .bottom) {
            
            
            VStack {
                
                ZStack(alignment: .bottomTrailing) {
                    
                    Color.gray.opacity(0.1)
                    PDFViewWrapper(pdfURL: URL(string: vm.noteModel?.localUrl ?? "https://firebasestorage.googleapis.com/v0/b/skillswisp.appspot.com/o/Muhammad_Mobile_Dev_CV.pdf?alt=media&token=8e29db90-9cf4-4d46-a93a-13d03df3b307")!)
                    
                    
                    VStack{
                        
                        Button(action: {
                            
                            guard vm.isLogin else {
                                print("Please login first")
                                return
                            }
                            
                            guard let noteId = dataStore.note_id,
                                  let subjectId = dataStore.subject_id,
                                  let standardId = dataStore.standard_id,
                                  let likeCount = vm.noteModel?.likesCount,
                                  !vm.isLiked else {
                                return
                            }
                            
                            Task {
                                await vm.addLike(standard_id: standardId, subject_id: subjectId, note_id:noteId, like:true)
                                await vm.updateLikesCount(standard_id: standardId, subject_id: subjectId, note_id: noteId, count: likeCount+1)
                            }
                        }, label: {
                            
                            Image(systemName: "hand.thumbsup")
                                .foregroundColor(vm.isLiked ? .white : .black)
                                .padding()
                                .background(Circle().foregroundColor(vm.isLiked ? Color("clr_purple_mimosa") : .white))
                        })
                        Text("\(vm.noteModel?.likesCount ?? 0)")
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
                            ReviewsView(dataStore: dataStore)
                        }
                        Text("\(vm.noteModel?.reviewCount ?? 0)")
                            .font(.system(size: 14))
                        
                    }
                    .padding()
                    
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                        guard vm.isLogin else {
                            print("Please login first")
                            return
                        }
                        
                        guard let note = vm.noteModel else {
                            return
                        }
                        //vm.isLoading = true
                        Task {
                            
                            await vm.downloadNote(note: note)
                        }
                        
                    }, label: {
                        
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.black)
                            .padding()
                            .background(Circle().foregroundColor(.white))
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                        guard vm.isLogin else {
                            print("Please login first")
                            return
                        }
                        
                        guard let noteId = dataStore.note_id,
                              let subjectId = dataStore.subject_id,
                              let standardId = dataStore.standard_id,
                              !vm.isBookmark else {
                            return
                            
                        }
                        Task {
                            await vm.addBookmark(standard_id: standardId, subject_id: subjectId, note_id:noteId, bookmark:true)
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
            
            
        }
        .onAppear{
            Task {
                //vm.fetchNoteById(id: dataStore.note_id ?? "")
                if let note = dataStore.selectedNote {
                    vm.populateNote(note: note)
                }
                guard let noteId = dataStore.note_id else { return }
                await vm.isLiked(note_id: noteId)
                await vm.isBookmarked(note_id: noteId)
            }
        }
        .navigationTitle("Notes")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct NotesScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(dataStore: StandSubjNoteDataStore())
    }
}
