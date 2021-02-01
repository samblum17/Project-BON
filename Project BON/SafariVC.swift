//
//  SafariView.swift
//  (Originally used in Project AA)
//
//  Created by Sam Blum on 3/2/20.
//  Copyright © 2020 Sam Blum. All rights reserved.
//

import SwiftUI
import SafariServices
import Foundation
import MessageUI

//Generic mail composer UI
public struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    public var configure: ((MFMailComposeViewController) -> Void)?
    
    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?
        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }
        
        public func mailComposeController(_ controller: MFMailComposeViewController,
                                          didFinishWith result: MFMailComposeResult,
                                          error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }
    public func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }
    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        configure?(vc)
        return vc
    }
    public func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: UIViewControllerRepresentableContext<MailView>) {
    }
}


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
