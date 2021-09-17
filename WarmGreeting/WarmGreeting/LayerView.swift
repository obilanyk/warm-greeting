//
//  LayerView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 07.09.2021.
//

import SwiftUI

struct LayerView: View {
    let count: Int = 43
    @Binding var bgImage: Image?
    @Binding var editBgr: Bool
    @State private var showActionSheet = false
    @State private var isShowPhotoLibrary = false
    @State private var isShowCamera = false
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            VStack {
                Spacer()
                ZStack {
                    VStack {
                        Button(action: {
                            editBgr.toggle()
                        }, label: {
                            Text("Done")
                                .foregroundColor(Color("mainColor"))
                                .frame(width: UIScreen.main.bounds.width - 20, alignment: .trailing)
                        })
                        Divider().foregroundColor(Color("mainColor"))
                            .padding(.bottom)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                GalleryPickView()
                                    .padding(2)
                                    .onTapGesture {
                                        showActionSheet = true
                                    }
                                    .actionSheet(isPresented: $showActionSheet, content: {
                                            ActionSheet(title: Text("Choose a new photo"),
                                                    message: Text("Pick a photo that you like"),
                                                    buttons: [
                                                        .default(Text("Pick from library")) {
                                                            isShowPhotoLibrary = true
                                                  print("Tapped on pick from library")
                                              },
                                              .default(Text("Take a photo")) {
                                                  print("Tapped on take a photo")
                                                isShowCamera = true
                                              },
                                              .cancel()
                                            ])
                                    })
                                    .sheet(isPresented: $isShowPhotoLibrary) {
                                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$bgImage)
                                    }
                                    .sheet(isPresented: $isShowCamera) {
                                        ImagePicker(sourceType: .camera, selectedImage: self.$bgImage)
                                    }
                                ForEach(1 ..< count, id: \.self) { giftIndex in
                                    GiftSubview(name: ("bgr\(giftIndex)")).onTapGesture {
                                        let imageBg = "bgr\(giftIndex)"
                                        bgImage = Image(imageBg)
                                    }
                                    .padding(2)
                                }
                            }
                        }
                    }.padding(.bottom).background(Color.white.opacity(0.8))
                }
            }
        }
    }
}

struct LayerView_Previews: PreviewProvider {
    static var previews: some View {
        LayerView(bgImage: .constant(Image("bgr1")), editBgr: .constant(false))
    }
}
struct GiftSubview: View {
    let name: String
    var imageSize: CGFloat  = 150
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: imageSize)
            .scaledToFill()
            .padding(2)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0.0, y: 0.0)
    }
}

struct GalleryPickView: View {
    var imageSize: CGFloat  = 150
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("listColor"),
                                                       Color("listColor2")]),
                           startPoint: .top, endPoint: .bottom)
                .frame(width: 100, height: imageSize)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0.0, y: 0.0)
            Image(systemName: "plus")
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
                .foregroundColor(.white.opacity(0.5))
        }
    }
}
