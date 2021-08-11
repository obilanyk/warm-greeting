//
//  ContentView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 28.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var greetingListVM = GreetingListViewModel()
    var body: some View {
        NavigationView {
            List(greetingListVM.greetings, id: \.id) { greeting in
                GreetingCellView(greeting: greeting)}
                .onAppear {
                    greetingListVM.getAllGreetings()
                }
                .padding(EdgeInsets(top: 10.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                
                .navigationBarTitle(Text("Warm Greeting"), displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination: AddGreetingView()) {
                            Image(systemName: "plus")
                                .shadow(color: .black, radius: 10, x: 0.0, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
        }
        .foregroundColor(.blue)
        .accentColor(.black)
    }
    func addGreeting() {
        
    }
    func removeGreeting(at offsets: IndexSet) {
        for index in offsets {
            let greeting = greetingListVM.greetings[index]
            greetingListVM.deleteGreeting(greeting)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
