//
//  Help.swift
//  Project BON
//
//  Created by Sam Blum on 1/29/21.
//

import SwiftUI
import SafariServices

struct Help: View {
    @State private var showingVC = false

    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading){
                Text("Data pulled from Vanderbilt University's COVID-19 Dashboard:")
                    .foregroundColor(.white)
                Button(action: {
                    self.showingVC.toggle()
                }) {
                    Text("https://docs.google.com/spreadsheets/d/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/edit#gid=693781790")
                    .foregroundColor(Color.blue)
                }.sheet(isPresented: $showingVC, content:{
                    SafariView(safariVC: SFSafariViewController(url: URL(string: "https://docs.google.com/spreadsheets/d/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/edit#gid=693781790")!), urlString: "https://docs.google.com/spreadsheets/d/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/edit#gid=693781790")
                })
                .padding(.bottom)
               
                Text("View updated campus protocols on the official Return to Campus website:").foregroundColor(.white)
                Button(action: {
                    self.showingVC.toggle()
                }) {
                    Text("https://www.vanderbilt.edu/coronavirus/")
                    .foregroundColor(Color.blue)
                }.sheet(isPresented: $showingVC, content:{
                    SafariView(safariVC: SFSafariViewController(url: URL(string: "https://www.vanderbilt.edu/coronavirus/")!), urlString: "https://www.vanderbilt.edu/coronavirus/")
                })
            }.padding()
            
        }
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}
