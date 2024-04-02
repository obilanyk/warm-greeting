//
//  SearchBar.swift
//  WarmGreeting
//
//  Created by Olha Bilanyk on 17.08.2021.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    let placeholder: String

    func makeCoordinator() -> SearchCoordiantor {
        return SearchCoordiantor(text: $text)
    }
    func makeUIView(context: Context) -> some UIView {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        return searchBar
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

final class SearchCoordiantor: NSObject, UISearchBarDelegate {
    @Binding var text: String

    init(text: Binding<String>) {
        self._text = text
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        text = searchText
    }
}
