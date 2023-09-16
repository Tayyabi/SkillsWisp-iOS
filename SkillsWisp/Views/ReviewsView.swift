//
//  ReviewsScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 11/06/2023.
//

import SwiftUI

struct ReviewsView: View {
    
    @State var selected: Int = -1
    @State var comment: String = ""
    @State var showReview: Bool = false
    
    @ObservedObject var dataStore: StandSubjNoteDataStore
    @StateObject var vm = ReviewsViewModel()
    
    var body: some View {
        
        ZStack {
            VStack {
                
                HStack {
                    VStack {
                        
                        Text("\(String(format: "%.1f", vm.totalRating))")
                            .font(.system(size: 45))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        
                        Text("\(vm.savedRatings.count) Reviews")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    VStack {
                        
                        HStack(spacing: 10){
                            ForEach(1..<6){ i in
                                
                                Image(systemName: "star.fill").resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(5 >= i ? .yellow : .gray)
                                    
                            }
                            
                            Text("(\(vm.fiveStar))")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        
                        HStack(spacing: 10){
                            ForEach(1..<6){ i in
                                
                                Image(systemName: "star.fill").resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(4 >= i ? .yellow : .gray)
                                   
                            }
                            Text("(\(vm.fourStar))")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        HStack(spacing: 10){
                            ForEach(1..<6){ i in
                                
                                Image(systemName: "star.fill").resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(3 >= i ? .yellow : .gray)
                                    
                            }
                            Text("(\(vm.threeStar))")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        HStack(spacing: 10){
                            ForEach(1..<6){ i in
                                
                                Image(systemName: "star.fill").resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(2 >= i ? .yellow : .gray)
                                    
                            }
                            Text("(\(vm.twoStar))")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        HStack(spacing: 10){
                            ForEach(1..<6){ i in
                                
                                Image(systemName: "star.fill").resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(1 >= i ? .yellow : .gray)
                                    
                            }
                            Text("(\(vm.oneStar))")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                        }
                    }
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity)
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.yellow, lineWidth: 1)
                )
                .padding([.leading,.trailing,.top], 25)
                
                
                HStack {
                    
                    Text("Recent Reviews")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.showReview.toggle()
                    }, label: {
                        
                        Text("Review Now")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color("clr_purple_mimosa").cornerRadius(10))
                        
                    })
                }
                .padding()
                
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        
                        ForEach(vm.savedEntities.indices, id: \.self) { index in
                                
                                let review = vm.savedEntities[index]
                            
                            
                            VStack {
                                HStack {
                                    
                                    Image("bn_maths")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50,height: 50)
                                        .clipShape(Circle())
                                        .overlay(Circle())
                                    
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        
                                        HStack(alignment: .center) {
                                            
                                            Text("John Smith")
                                                .foregroundColor(.black)
                                                .fontWeight(.semibold)
                                            
                                            Spacer()
                                            
                                            
                                        }
                                        
                                        Text(review.review ?? "")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 13))
                                    }
                                    
                                    
                                    
                                }
                                .padding()
                                
                                
                                Divider()
                                    .padding([.leading, .trailing], 15)
                            }
                            
                        }
                        
                    }
                }
                HStack{
                    
                    TextField("Type here", text: $comment)
                        .font(.system(size: 16))
                    
                    //                Image(systemName: "person")
                    //                    .foregroundColor(Color.gray)
                    
                    Button(action: {
                        
                        guard let noteId = dataStore.note_id,
                              let standardId = dataStore.standard_id,
                              let subjectId = dataStore.subject_id,
                              !comment.isEmpty else {
                            return
                        }
                        Task {
                            try? await vm.addReview(standardId: standardId, subjectId: subjectId, noteId: noteId, review: comment)
                            
                            comment = ""
                        }
                    }, label: {
                        
                        Text("Submit")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color("clr_purple_mimosa").cornerRadius(10))
                        
                    })
                    
                }
                .padding(10)
                .background(Color("clr_light_grey").cornerRadius(radius: 10, corners: .allCorners))
                .padding([.leading, .trailing])
                Spacer()
                
            }
            
            if self.showReview {
                RatingView(confirm: $showReview, dataStore: dataStore)
            }
            
            
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
            }
        }
        .onAppear{
            Task {
                guard let noteId = dataStore.note_id,
                      let standardId = dataStore.standard_id,
                      let subjectId = dataStore.note_id else {
                    return
                }
            
                await vm.fetchReviews(standard_id: standardId, subject_id: subjectId, note_id: noteId)
                await vm.fetchRatings(note_id: noteId)
                
            }
        }
    }
}

struct ReviewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(dataStore: StandSubjNoteDataStore())
    }
}
