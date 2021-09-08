//
//  ContentView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 28.07.2021.
//
// swiftlint: disable line_length

import SwiftUI

struct ContentView: View {
    @State var searchText: String = ""
    @State var selectedSearchScopeIndex: Int = 0

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
                            SearchBar(text: $searchText, placeholder: "Search by name or content")
                                .zIndex(-1.0)
                            if !searchText.isEmpty {
                                Picker("", selection: $selectedSearchScopeIndex) {
                                    ForEach(0 ..< Category.allCases.count, id: \.self) { categoryIndex in
                                        let categoryType = Category.allCases[categoryIndex]
                                        Text(categoryType.rawValue).tag(categoryIndex)
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                                .zIndex(-1.0)
                            }

                        FilteredList(filterValue: searchText, categoryIndex: selectedSearchScopeIndex
//                                     , sortField: [NSSortDescriptor(keyPath: \Greeting.objectID, ascending: true)]
                        ) { (greeting: Greeting) in
//                            Text("\(greeting.name ?? "") ")
                            GreetingCellView(greeting: greeting)
                                .contextMenu {
                                    Button("Delete") {
                                        PersistentController.shared.delete(greeting)

                                    }
                                }
                        }
                    }
//                }
                .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
            }
            .navigationBarTitle(Text("Warm Greeting"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddGreetingView()
//                                    .environment(\.managedObjectContext, viewContext)
                    ) {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
