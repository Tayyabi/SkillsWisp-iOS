//
//  SubjectScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 23/05/2023.
//

import SwiftUI
class StandSubjNoteDataStore: ObservableObject {
    @Published var standard_id: String?
    @Published var subject_id: String?
    @Published var note_id: String?
    @Published var selectedNote: NoteModel?
}

struct SubjectView: View {
    
    @ObservedObject var dataStore: StandSubjNoteDataStore
    @StateObject var vm = SubjectViewModel()
    @State var shouldNavigate = false
    
    var gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: .leading),
        GridItem(.flexible(), spacing: 0, alignment: .leading)
    ]
    
    @State var thumbnails: [String] = ["bn_class_1","bn_class_2", "bn_class_3", "bn_class_4"]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        
        ZStack {
            
            
            VStack(spacing: nil) {
                
                
                ZStack{
                    
                    Image("bg_matric")
                        .resizable()
                        .frame(height: 250)
                    
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image("ic_left_arrow")
                                    .padding(.bottom)
                            })
                            
                            Text("Physics")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.title2)
                            
                            Text("Get solved notes by top professors of Pakistan")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                            
                            
                        }
                        
                        Image("ic_subj")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .padding(.top,20)
                        
                        
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity
                    )
                    
                }
                

                ScrollView(showsIndicators: false) {

                    LazyVGrid(columns: gridItems) {

                        ForEach(vm.savedEntities.indices, id: \.self) { index in

                            let note = vm.savedEntities[index]

                            VStack{
                                Button(action: {

                                    if let note_id = note.noteId {
                                        dataStore.note_id = note_id
                                        dataStore.selectedNote = note
                                        shouldNavigate = true
                                    }
                                }, label: {
                                    VStack(alignment: .leading) {


                                        Image("\(thumbnails[index % thumbnails.count])")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 180)
                                            .clipShape(RoundedRectangle(cornerRadius: 15))

                                        HStack {
                                            Text(note.name ?? "")
                                                .font(.system(size: 15))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundColor(.black)

                                            Spacer()
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)

                                            Text("\(String(format: "%.1f", note.rating))")
                                                .foregroundColor(.black)
                                                .font(.system(size: 14))

                                        }
                                        .frame(
                                            maxWidth: .infinity
                                        )

                                        Text("\(note.chapter ?? "")")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)


                                    }
                                    .padding(4)
                                })

                                
                            }

                        }
                        
                        NavigationLink(destination:NotesView(dataStore: dataStore),isActive: $shouldNavigate) {
                            EmptyView()
                        }
                        .hidden()

                    }
                }
                
                
                Spacer()
            }
            
        }
        .onAppear{
            
            guard let standarId = dataStore.standard_id,
                  let subjectId = dataStore.subject_id else {
                return
            }
            
            Task{
                //vm.fetchNotesById(id: dataStore.id ?? "")
                await vm.fetchNotesFromDB(standard_id: standarId, subject_id: subjectId)
            }
        }
        .edgesIgnoringSafeArea([.leading,.trailing,.top])
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct SubjectScreen_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView(dataStore: StandSubjNoteDataStore())
    }
}
