//
//  GreetingDetailView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 04.08.2021.
//
// swiftlint:disable multiple_closures_with_trailing_closure
import SwiftUI

struct GreetingDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let greeting: Greeting

    @State private var greetingViewState = GreetingViewState()
    @State private var showingActionSheet = false
    @State private var placeholder: String = "Enter text"
    var body: some View {
        ZStack {
            Color("mainColor")
                .ignoresSafeArea()
            GreetingEditView(greetingViewState: $greetingViewState)
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
//        let greeting = Greeting()
        return GreetingDetailView(greeting: Greeting())
    }
}
