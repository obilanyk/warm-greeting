//
//  GreetingDetailView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 04.08.2021.
//

import SwiftUI

struct GreetingDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let greeting: GreetingViewModel
    @ObservedObject private var updateGreetingViewModel = UpdateGreetingViewModel()
    @State private var greetingViewState = GreetingViewState()
    @State private var showingActionSheet = false
    
    var body: some View {
        ZStack{
            Color("mainColor")
                .ignoresSafeArea()
            VStack{
                TextField("Enter task name", text: $greetingViewState.name)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 8.0, leading: 8.0, bottom: 12.0, trailing: 8.0))
                Group{
                    VStack{
                        TextEditor(text:  $greetingViewState.content)
                            .foregroundColor(.black)
                            .font(.body)
                            .padding(EdgeInsets(top: 8.0, leading: 8.0, bottom: 32.0, trailing: 8.0))
                        Divider().foregroundColor(Color("mainColor"))
                            .padding(EdgeInsets(top: 8.0, leading: 0.0, bottom: 16.0, trailing: 0.0))
                        HStack(alignment: .center, spacing: 5, content: {
                            Text(greetingViewState.category.description)
                                
                                .foregroundColor(Color("mainColor"))
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                                
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .actionSheet(isPresented: $showingActionSheet) {
                                    ActionSheet(title: Text("Category"), message: Text("Change category"), buttons:
                                                    
                                                    
                                                    getCategoryBtn()
                                                
                                    )
                                }
                            RatingView(rating: $greetingViewState.mark)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        } )
                        .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 16.0, trailing: 8.0))
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.9), radius: 5, x: 0.0, y: 0.0)
                .padding(EdgeInsets(top: 8.0, leading: 8.0, bottom: 32.0, trailing: 8.0))
                .onAppear {
//                    self.greetingViewState.greetingId = self.greeting.greetingId
                    self.greetingViewState.name = self.greeting.name
                    self.greetingViewState.content = self.greeting.content
                    self.greetingViewState.category = self.greeting.category
                    self.greetingViewState.favourite = self.greeting.favourite
                    self.greetingViewState.mark = self.greeting.mark
                }
            }}
            .background(Color.init(.red))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: saveGreeting){
                        Image(systemName: "checkmark")
                            .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                    }
                }
            }
    }
    func saveGreeting() {
        updateGreetingViewModel.update(id: greeting.id, greetingViewState: greetingViewState)
        self.presentationMode.wrappedValue.dismiss()
    }
    func changeCategory()  {
        
    }
    func getCategoryBtn() -> Array<Alert.Button>{
        var buttons: [Alert.Button] = []
        
        buttons = Category.all.map({ item in
            Alert.Button.default(Text(item.description)) { greetingViewState.category = item   }
        })
        buttons.append(Alert.Button.cancel())
        return buttons
    }
}

struct GreetingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let greeting = Greeting()
        return GreetingDetailView(greeting: GreetingViewModel(greeting: greeting))
    }
}
