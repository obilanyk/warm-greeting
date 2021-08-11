//
//  GreetingEditView.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 09.08.2021.
//

import SwiftUI

struct GreetingEditView: View {
    @Binding var greetingViewState : GreetingViewState
    @State private var showingActionSheet = false
    @State private var placeholder: String = "Enter text"
    var body: some View {
        VStack{
            TextField("Enter task name", text: $greetingViewState.name)
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding(EdgeInsets(top: 8.0, leading: 8.0, bottom: 12.0, trailing: 8.0))
            Group{
                VStack{
                    
                    ZStack {
                        if self.greetingViewState.content.isEmpty {
                            TextEditor(text:$placeholder)
                                .font(.body)
                                .foregroundColor(.gray)
                                .disabled(true)
                                .padding(EdgeInsets(top: 8.0, leading: 8.0, bottom: 32.0, trailing: 8.0))
                        }
                        TextEditor(text:$greetingViewState.content)
                            .foregroundColor(.black)
                            .font(.body)
                            .opacity(self.greetingViewState.content.isEmpty ? 0.25 : 1)
                            
                            .padding(EdgeInsets(top: 8.0, leading: 8.0, bottom: 32.0, trailing: 8.0))
                        
                        
                    }
                    
                   
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
        }
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
//
//struct GreetingEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        GreetingEditView(greetingViewState: GreetingViewState())
//        
//    }
//}
