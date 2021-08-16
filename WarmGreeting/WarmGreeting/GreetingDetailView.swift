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
    let greeting: GreetingViewModel
    @EnvironmentObject var greetingListVM: GreetingListViewModel
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
            self.greetingViewState.name = self.greeting.name
            self.greetingViewState.content = self.greeting.content
            self.greetingViewState.category = self.greeting.category
            self.greetingViewState.favourite = self.greeting.favourite
            self.greetingViewState.mark = self.greeting.mark
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
        greetingListVM.update(objectId: greeting.id, greetingViewState: greetingViewState)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct GreetingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let greeting = Greeting()
        return GreetingDetailView(greeting: GreetingViewModel(greeting: greeting))
    }
}
