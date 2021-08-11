//
//  AddGreetingView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 09.08.2021.
//

import SwiftUI

struct AddGreetingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject private var greetingListViewModel = GreetingListViewModel()
    @State private var greetingViewState = GreetingViewState()
    @State private var showingActionSheet = false
    @State private var placeholder: String = "Enter text"
    var body: some View {
        ZStack{
            Color("mainColor")
                .ignoresSafeArea()
            GreetingEditView(greetingViewState: $greetingViewState)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:  Button(action: { saveGreeting() }) {
            Image(systemName: "chevron.left")
        })
    }
    func saveGreeting() {
        greetingListViewModel.save(greetingViewState: greetingViewState)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddGreetingView_Previews: PreviewProvider {
    static var previews: some View {
        AddGreetingView()
    }
}
