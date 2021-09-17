//
//  FontView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 07.09.2021.
//

import SwiftUI
// import UIKit
// swiftlint:disable all

struct FontView: View {
    let fonts = [ "Academy Engraved LET", "Al Nile", "American Typewriter", "Apple Color Emoji", "Apple SD Gothic Neo", "Arial Hebrew", "Arial Rounded MT Bold", "Arial", "Avenir Next Condensed", "Avenir Next", "Avenir", "Bangla Sangam MN", "Baskerville", "Bodoni 72 Oldstyle", "Bodoni 72 Smallcaps", "Bodoni 72", "Bradley Hand", "Chalkboard SE", "Chalkduster", "Cochin", "Courier New", "Courier", "Damascus", "Devanagari Sangam MN", "Didot", "Euphemia UCAS", "Farah", "Futura", "Geeza Pro", "Georgia", "Gill Sans", "Gujarati Sangam MN", "Gurmukhi MN", "Heiti SC", "Heiti TC", "Helvetica Neue", "Helvetica", "Hiragino Mincho ProN", "Hiragino Sans", "Hoefler Text", "Iowan Old Style", "Kailasa", "Kannada Sangam MN", "Khmer Sangam MN", "Kohinoor Bangla", "Kohinoor Devanagari", "Kohinoor Telugu", "Lao Sangam MN", "Malayalam Sangam MN", "Marker Felt", "Menlo", "Mishafi", "Noteworthy", "Optima", "Oriya Sangam MN", "Palatino", "Papyrus", "Party LET", "PingFang HK", "PingFang SC", "PingFang TC", "Savoye LET", "Sinhala Sangam MN", "Snell Roundhand", "Symbol", "Tamil Sangam MN", "Telugu Sangam MN", "Thonburi", "Times New Roman", "Trebuchet MS", "Verdana", "Zapf Dingbats", "Zapfino","Copperplate"]
    private let height = UIScreen.main.bounds.height / 2
    private let width = UIScreen.main.bounds.width //- 20
    //    @Binding var fontName: Font
    @Binding var fontName: String
    
    @Binding var editFont: Bool
    @Binding var fontSize: Double
    @State private var editing = false
    @State var name: String = "Al Nile"
    let minSize: Double = 14
    let maxSize: Double = 40
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            VStack {
                Spacer()
                ZStack {
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                        VStack {
                            
                            Button(action: {
                                editFont.toggle()
                            }, label: {
                                Text("Done")
                                    .foregroundColor(Color("mainColor"))
                                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .trailing)
                            })
                            Divider().foregroundColor(.white)
                                .padding(.bottom)
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack {
                                    ForEach(0 ..< fonts.count, id: \.self) { fontIndex in
                                        let fontname = fonts[fontIndex]
                                        Text(fontname)
                                            .padding(5)
                                            .font(.custom(fontname, size: 20.0).bold()) .foregroundColor(Color("mainColor"))
                                            .onTapGesture {
                                                fontName = fontname
                                            }
                                    }
                                }
                            }
                        }
                        .background(Color.white.opacity(0.8))
                        .opacity(editing ? 0.0 : 1.0)
                        VStack {
                            HStack {
                                Text("\(Int(minSize))")
                                    .font(.body.bold()).foregroundColor(Color("colorSlider"))
                                    .padding(.leading, 5)
                                
                                Slider(value: Binding(get: {
                                    self.fontSize
                                }, set: { (newVal) in
                                    self.fontSize = newVal
                                    self.sliderChanged()
                                }), in: minSize...maxSize, step: 1) { _ in
                                    editing = false
                                }
                                .accentColor(Color("colorSlider"))
                                Text("\(Int(maxSize))")
                                    .font(.body.bold()).foregroundColor(Color("colorSlider"))
                                    .padding(.trailing, 5)
                            }
                            Text("\(Int(fontSize))")
                        }
                        .padding(.bottom).background(Color.white.opacity(0.8))
                        
                    }.frame(width: width)
                }
            }
        }
        .frame(width:  self.width, height: self.height, alignment: .bottom)
        .animation(.default)
    }
    func sliderChanged() {
        print("Slider value changed to \(fontSize)")
        editing = true
        
    }
}

struct FontView_Previews: PreviewProvider {
    static var previews: some View {
        FontView( fontName: .constant(""), editFont: .constant(false), fontSize: .constant(20))
    }
}

