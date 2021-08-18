//
//  ContentView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 28.07.2021.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var greetingListVM = GreetingListViewModel()

    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("listColor"), Color("listColor2")]),
                               startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    VStack {
                            SearchBar(text: $greetingListVM.searchText, placeholder: "Search by name or content")
                                .zIndex(-1.0)
                            if !greetingListVM.searchText.isEmpty {
                                Picker("", selection: $greetingListVM.selectedSearchScopeIndex) {
                                    ForEach(0 ..< Category.allCases.count, id: \.self) { categoryIndex in
                                        let categoryType = Category.allCases[categoryIndex]
                                        Text(categoryType.rawValue).tag(categoryIndex)
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                                .zIndex(-1.0)
                            }
                            List {
                                ForEach(greetingListVM.greetings, id: \.id) {greeting in
                                    GreetingCellView(greeting: greeting)
                                        .contextMenu {
                                            Button("Delete") {
                                                greetingListVM.deleteGreeting(greeting)
                                            }
                                        }
                                }
                                .listRowBackground(Color.clear)
                                .listStyle(GroupedListStyle())
                            }
                            .background(Color.clear)
                    }
//                }
                .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
            }
            .navigationBarTitle(Text("Warm Greeting"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddGreetingView()) {
                        Image(systemName: "plus")
                            .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.blue)
        .accentColor(.black)
        .environmentObject(greetingListVM)
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
