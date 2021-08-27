//
//  AddGreetingView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 09.08.2021.
//
// swiftlint:disable multiple_closures_with_trailing_closure
import SwiftUI

struct AddGreetingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var greetingViewState = GreetingViewState()

    var body: some View {
        ZStack {
            Color("mainColor")
                .ignoresSafeArea()
            GreetingEditView(greetingViewState: $greetingViewState)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
                                    saveGreeting()
                                }) {
                                    Image(systemName: "chevron.left")
                                })
    }

    func saveGreeting() {
        PersistentController.shared.createGreeting(with: greetingViewState)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddGreetingView_Previews: PreviewProvider {
    static var previews: some View {
        AddGreetingView()
    }
}
