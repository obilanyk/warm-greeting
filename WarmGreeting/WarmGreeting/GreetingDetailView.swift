//
//  GreetingDetailView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 04.08.2021.
//
// swiftlint:disable multiple_closures_with_trailing_closure
import SwiftUI

struct GreetingStyle {
    var bgrScreen: String = ""
    var color: Color = .black
    var fontName: Font = .body
    var weight: Font.Weight = Font.Weight.regular
}

struct GreetingDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let greeting: Greeting
    @State private var color: Color = .black
    @State private var greetingViewState = GreetingViewState()
    @State private var showingActionSheet = false
    @State private var shareActionSheet = false
    @State private var placeholder: String = "Enter text"
    @State private var editBgr = false
    @State private var editfont = false
    @State private var takePic = false
    @State private var greetingStyle = GreetingStyle()
    
    var body: some View {
        ZStack {
            Color("mainColor")
                .ignoresSafeArea()
            GreetingEditView(greetingViewState: $greetingViewState, greetingStyle: $greetingStyle, takePic: $takePic)
            if editBgr {
                VStack {
                    Spacer()
                    LayerView(imageBg: $greetingStyle.bgrScreen, editBgr: $editBgr)
                        .frame(alignment: .bottom)
                        .ignoresSafeArea()
                }
            }
            if editfont {
                VStack {
                    Spacer()
                    FontView(fontName: $greetingStyle.fontName, editFont: $editfont)
                        .frame(alignment: .bottom)
                        .ignoresSafeArea()
                }
            }
        }
        .onAppear {
            self.greetingViewState.name = self.greeting.wrappedName
            self.greetingViewState.content = self.greeting.wrappedContent
            self.greetingViewState.category = self.greeting.wrappedCategory
            self.greetingViewState.favourite = self.greeting.favourite
            self.greetingViewState.mark = self.greeting.wrappedMark
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
                                    saveGreeting()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .renderingMode(.template)
                                        .foregroundColor(.black)
                                },
                            trailing:
                                HStack {
                                    Button(action: {
                                            editBgr = false
                                            editfont = false
                                            shareActionSheet = true                                        }) {
                                        Image(systemName: "square.and.arrow.up")
                                            .renderingMode(.template)
                                            .foregroundColor(.black)
                                    }
                                    .alert(isPresented: $shareActionSheet) {
                                        Alert(
                                            title: Text("Import Card"),
                                            message: Text("Image will be saved to the photo galery"),
                                            primaryButton: .destructive(Text("Import")) {
                                                print("Deleting...")
                                                takePic.toggle()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                    ColorPicker("", selection: $greetingStyle.color)
                                    Button(action: {
                                        editBgr = false
                                        editfont.toggle()
                                    }, label: {
                                        Image(systemName: "character.textbox")
                                            .foregroundColor(.black)
                                    })
                                    Button(action: {
                                        editfont = false
                                        editBgr.toggle()
                                    }, label: {
                                        Image(systemName: "photo")
                                            .foregroundColor(.black)
                                    })
                                    Button(action: {
                                        showingActionSheet = true
                                    }) {
                                        Image(systemName: "trash")
                                            .renderingMode(.template)
                                            .foregroundColor(.black)
                                    }
                                    .alert(isPresented: $showingActionSheet) {
                                        Alert(
                                            title: Text("Are you sure you want to delete this?"),
                                            message: Text("There is no undo"),
                                            primaryButton: .destructive(Text("Delete")) {
                                                print("Deleting...")
                                                PersistentController.shared.delete(greeting)
                                                self.presentationMode.wrappedValue.dismiss()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                })
    }
    func saveGreeting() {
        self.greeting.objectWillChange.send()
        self.greeting.name = greetingViewState.name
        self.greeting.category = greetingViewState.category.description
        self.greeting.content = greetingViewState.content
        self.greeting.favourite = greetingViewState.favourite
        self.greeting.mark = Int16(greetingViewState.mark)
        PersistentController.shared.update { error in
            print( "error \(String(describing: error?.localizedDescription))")
        }
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct GreetingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return GreetingDetailView(greeting: Greeting())
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.screenShot
    }
}
extension UIView {
    var screenShot: UIImage {
        let rect = self.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return capturedImage
    }
}
