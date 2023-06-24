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

struct SplashScreen: View {
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                
                Color("clr_fantasy")
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
                            .frame(width: .infinity, height: 400)
                            .cornerRadius(radius: 50.0, corners: [.topLeft,.topRight])
                            .padding(.bottom, -110)
                            
                        
                        VStack{
                            
                            Spacer()
                            Text("**Discover your limitless potential with us**")
                                .padding([.leading,.trailing,.top])
                                .font(.title2)
                                .multilineTextAlignment(.center)
                                .frame(alignment: .center)
                            
                            
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray)
                                .padding([.leading, .trailing])
                            
                            Spacer()
                            
                            NavigationLink(destination: WelcomeScreen(), label: {
                                
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
                .frame(width: .infinity, height: .infinity)
                
            }
            
        }
    
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
