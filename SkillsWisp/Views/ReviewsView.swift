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
    
    @ObservedObject var dataStore: DataStore1
    @StateObject var vm = ReviewsViewModel()
    
    var body: some View {
        
        ZStack {
            VStack {
                
                HStack {
                    VStack {
                        
                        Text("4.9")
                            .font(.system(size: 45))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        
                        Text("48 Reviews")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    VStack {
                        
                        HStack(spacing: 10){
                            ForEach(0..<5){ i in
                                
                                Image(systemName: "star.fill").resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(self.selected >= i ? .yellow : .gray)
                                    .onTapGesture {
                                        self.selected = i
                                    }
                            }
                        }
                        
                        HStack(spacing: 10){
                            ForEach(0..<5){ i in
                                
                                Image(systemName: "star.fill").resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(self.selected >= i ? .yellow : .gray)
                                    .onTapGesture {
                                        self.selected = i
                                    }
                            }
                        }
                        HStack(spacing: 10){
                            ForEach(0..<5){ i in
                                
                                Image(systemName: "star.fill").resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(self.selected >= i ? .yellow : .gray)
                                    .onTapGesture {
                                        self.selected = i
                                    }
                            }
                        }
                        HStack(spacing: 10){
                            ForEach(0..<5){ i in
                                
                                Image(systemName: "star.fill").resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(self.selected >= i ? .yellow : .gray)
                                    .onTapGesture {
                                        self.selected = i
                                    }
                            }
                        }
                        HStack(spacing: 10){
                            ForEach(0..<5){ i in
                                
                                Image(systemName: "star.fill").resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(self.selected >= i ? .yellow : .gray)
                                    .onTapGesture {
                                        self.selected = i
                                    }
                            }
                            
                        }
                    }
                    .padding(.leading, 20)
                    
                    
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
                        
                        guard let noteid = dataStore.note_id,
                              let standard_id = dataStore.standard_id,
                              let subject_id = dataStore.subject_id,
                              !comment.isEmpty else {
                            return
                        }
                        Task {
                            try? await vm.addReview(standard_id: standard_id, subject_id: subject_id, note_id: noteid, review: comment)
                            
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
                RatingView()
            }
            
            
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
            }
        }
        .onAppear{
            Task {
                guard let noteid = dataStore.note_id,
                      let standard_id = dataStore.standard_id,
                      let subject_id = dataStore.subject_id else {
                    return
                }
            
                await vm.fetchReviews(standard_id:standard_id, subject_id: subject_id, note_id:noteid)
            }
        }
    }
}

struct ReviewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(dataStore: DataStore1())
    }
}
