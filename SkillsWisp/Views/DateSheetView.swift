//
//  DateSheetView.swift
//  SkillsWisp
//
//  Created by M Tayyab on 08/09/2023.
//

import SwiftUI

struct DateSheetView: View {
    
    var body: some View {
        
        
        VStack {
            
            ZStack(alignment: .bottomTrailing) {
                
                Color.gray.opacity(0.1)
                Image("bn_date_sheet")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                
                
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
            DateSheetView()
        }
    }
