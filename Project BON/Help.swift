//
//  Help.swift
//  Project BON
//
//  Created by Sam Blum on 1/29/21.
//

import SwiftUI
import SafariServices

struct Help: View {
    @State private var showingTable = false
    @State private var showingProtocols = false

    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading){
                Text("More Info").foregroundColor(.white)
                    .font(.largeTitle).bold()
                    .padding(.bottom)
                    .padding(.bottom)
                Text("Data pulled from Vanderbilt University's Live COVID-19 Chart:")
                    .foregroundColor(.white)
                Button(action: {
                    self.showingTable.toggle()
                }) {
                    Text("https://docs.google.com/spreadsheets/d/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/edit#gid=693781790")
                    .foregroundColor(Color.blue)
                }.sheet(isPresented: $showingTable, content:{
                    SafariView(safariVC: SFSafariViewController(url: URL(string: "https://docs.google.com/spreadsheets/d/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/edit#gid=693781790")!), urlString: "https://docs.google.com/spreadsheets/d/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/edit#gid=693781790")
                })
                .padding(.bottom)
                .padding(.bottom)
                Text("Updated campus protocols from the official Return to Campus website:").foregroundColor(.white)
                Button(action: {
                    self.showingProtocols.toggle()
                }) {
                    Text("https://www.vanderbilt.edu/coronavirus/")
                    .foregroundColor(Color.blue)
                }.sheet(isPresented: $showingProtocols, content:{
                    SafariView(safariVC: SFSafariViewController(url: URL(string: "https://www.vanderbilt.edu/coronavirus/")!), urlString: "https://www.vanderbilt.edu/coronavirus/")
                })
                Spacer()
            }.padding()
        }
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}
