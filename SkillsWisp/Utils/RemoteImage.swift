//
//  RemoteImage.swift
//  SkillsWisp
//
//  Created by M Tayyab on 13/08/2023.
//

import SwiftUI

struct RemoteImage: View {
    private var url: URL
    private var placeholder: Image

    @State private var image: UIImage? = nil

    init(url: URL, placeholder: Image = Image("ic_profile_img")) {
        self.url = url
        self.placeholder = placeholder
    }

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
        } else {
            placeholder
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .onAppear(perform: fetchImage)
        }
    }

    private func fetchImage() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }

            DispatchQueue.main.async {
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
