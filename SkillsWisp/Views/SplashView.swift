//
//  SplashScreen.swift
//  SkillsWisp
//
//  Created by M Tayyab on 11/05/2023.
//

import SwiftUI

struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

struct SplashView: View {
    
    var body: some View {
        
        NavigationStack {
            
            ZStack{
                
                //                Color("clr_fantasy")
                //                    .edgesIgnoringSafeArea(.all)
                Image("bg_splash")
                    .resizable()
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    
                    Text("Skills Wisp")
                        .font(.custom("Pacifico-Regular", size: 34))
                        .padding(.all, 40)
                        .foregroundColor(Color("clr_purple_mimosa"))
                    
                    
                    Image("ic_splash_img")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.green)
                        .frame(width: 400, height: 300)
                    
                    
                    Spacer()
                    
                    ZStack{
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: 400)
                            .cornerRadius(radius: 50.0, corners: [.topLeft,.topRight])
                            .padding(.bottom, -110)
                        
                        
                        VStack{
                            
                            Spacer()
                            Text("**Crafting Your Academic Journey**")
                                .padding([.leading,.trailing,.top])
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .frame(alignment: .center)
                            
                            
                            Text("Stay organized, study smarter, and achieve more with the XYRON NOTES app.")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray)
                                .padding([.leading, .trailing])
                                .padding(.top, 5)
                            
                            Spacer()
                            
                            NavigationLink(destination: WelcomeView(), label: {
                                
                                Text("Get Started")
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
                            })
                            Spacer()
                        }
                        
                    }
                    .ignoresSafeArea(edges: .bottom)
                    
                }
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: .infinity)
                
            }
            
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
