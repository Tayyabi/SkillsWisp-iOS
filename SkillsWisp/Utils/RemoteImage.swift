//
//  RemoteImage.swift
//  SkillsWisp
//
//  Created by M Tayyab on 13/08/2023.
//

import SwiftUI

struct RemoteImage: View {
    private var url: URL?
    private var placeholder: Image

    @State var isLoading = true
    @State private var image: UIImage? = nil

    init(url: URL?, placeholder: Image = Image("ic_profile_g")) {
        self.url = url
        self.placeholder = placeholder
        
    }

    var body: some View {
        ZStack(alignment: .center) {
           
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
            }
            else {
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                    
                } else {
                    placeholder
                        .resizable()
                }
            }
        }
        .onAppear(perform: fetchImage)
        
    }

    private func fetchImage() {
        guard let url = url else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }

            DispatchQueue.main.async {
                isLoading = false
                image = UIImage(data: data)
            }
        }.resume()
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: URL(string: "https://example.com/image.jpg")!)
    }
}
