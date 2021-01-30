//
//  SafariView.swift
//  (Originally used in Project AA)
//
//  Created by Sam Blum on 3/2/20.
//  Copyright © 2020 Sam Blum. All rights reserved.
//

import SwiftUI
import SafariServices

//Generic safari view template- can be customized for future apps
struct SafariView: UIViewControllerRepresentable {
    
    let safariVC: SFSafariViewController
    let urlString: String
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: URL(string: urlString )!)
        return safariVC
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        uiViewController.dismissButtonStyle = .close
    }
}

struct SafariView_Preview: PreviewProvider {
    static var previews: some View {
        SafariView(safariVC: SFSafariViewController.init(url: URL(string: "https://docs.google.com/spreadsheets/d/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/edit#gid=693781790")!), urlString: "https://docs.google.com/spreadsheets/d/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/edit#gid=693781790")
    }
}
