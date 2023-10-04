//
//  NoInternetView.swift
//  SkillsWisp
//
//  Created by M Tayyab on 03/10/2023.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        
        VStack(alignment: .center,spacing: 0) {
            
            Image("ic_no_network")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.green)
                .frame(width: 300, height: 300)
            
            Text("No Internet")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Please connect to internet and try again to start using app again")
                .multilineTextAlignment(.center)
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .padding()
            
            
            NavigationLink(destination: WelcomeView(), label: {
                
                Text("Try Again")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(15)
                    .frame(width: 300)
                    .background(
                        Color("clr_purple_mimosa")
                            .cornerRadius(10)
                            .shadow(radius: 6)
                        
                    )
                    .padding(.top)
                
            })
            
            NavigationLink(destination: DownloadsView(), label: {
                
                Text("Go to Downloads")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(15)
                    .frame(width: 300)
                    .background(
                        Color("clr_golden")
                            .cornerRadius(10)
                            .shadow(radius: 6)
                        
                    )
                    .padding(.top)
            })
        }
    }
}

struct NoInternetView_Previews: PreviewProvider {
    static var previews: some View {
        NoInternetView()
    }
}
