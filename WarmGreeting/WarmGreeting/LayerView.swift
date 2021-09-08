//
//  LayerView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 07.09.2021.
//

import SwiftUI

struct LayerView: View {
    let count: Int = 43
    @Binding var imageBg: String
    @Binding var editBgr: Bool
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
                                ForEach(1 ..< count, id: \.self) { giftIndex in
                                    GiftSubview(name: ("bgr\(giftIndex)")).onTapGesture {
                                        imageBg = "bgr\(giftIndex)"
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
        LayerView(imageBg: .constant("bgr1"), editBgr: .constant(false))
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
