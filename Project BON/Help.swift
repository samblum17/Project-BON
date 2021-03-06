//
//  Help.swift
//  Project BON
//
//  Created by Sam Blum on 1/29/21.
//

import SwiftUI
import SafariServices
import SwiftUI
import MessageUI

//Help screen
struct Help: View {
    //Show and hide SafariVC/MailVC with state vars
    @State private var showingTable = false
    @State private var showingProtocols = false
    @State private var showingDash = false
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailView = false
    
    var body: some View {
        NavigationView{
        ZStack{
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading){
                //Text and button for data source
                Text("Help").foregroundColor(.white)
                                   .font(.largeTitle).bold()
                                   .padding(.bottom)
                                   .padding(.bottom)
                Text("Data pulled from Vanderbilt University's Live COVID-19 Chart:")
                    .foregroundColor(.white)
                Button(action: {
                    self.showingTable.toggle()
                }) {
                    Text("https://docs.google.com/spreadsheets/d/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/edit#gid=693781790")
                        .foregroundColor(Color.yellow)
                }.sheet(isPresented: $showingTable, content:{
                    SafariView(safariVC: SFSafariViewController(url: URL(string: "https://docs.google.com/spreadsheets/d/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/edit#gid=693781790")!), urlString: "https://docs.google.com/spreadsheets/d/1QorVReLcwOEsqDEgWhVAlIlU3zJRNwu8m975aQ8MXpE/edit#gid=693781790")
                })
                .padding(.bottom)
                .padding(.bottom)
                
                //Text and button for official dashboard
                Text("Previous weekly testing data from the official Vanderbilt COVID-19 Dashboard:")
                    .foregroundColor(.white)
                Button(action: {
                    self.showingDash.toggle()
                }) {
                    Text("https://www.vanderbilt.edu/coronavirus/covid19dashboard/")
                        .foregroundColor(Color.yellow)
                }.sheet(isPresented: $showingDash, content:{
                    SafariView(safariVC: SFSafariViewController(url: URL(string: "https://www.vanderbilt.edu/coronavirus/covid19dashboard/")!), urlString: "https://www.vanderbilt.edu/coronavirus/covid19dashboard/")
                })
                .padding(.bottom)
                .padding(.bottom)
                
                //Text and button for official campus protocols
                Text("Updated campus protocols from the official Return to Campus website:").foregroundColor(.white)
                Button(action: {
                    self.showingProtocols.toggle()
                }) {
                    Text("https://www.vanderbilt.edu/coronavirus/")
                        .foregroundColor(Color.yellow)
                }.sheet(isPresented: $showingProtocols, content:{
                    SafariView(safariVC: SFSafariViewController(url: URL(string: "https://www.vanderbilt.edu/coronavirus/")!), urlString: "https://www.vanderbilt.edu/coronavirus/")
                })
                Spacer()
                
                //Disclaimer
//                Text("*App not affiliated with Vanderbilt University*").foregroundColor(.white).font(.system(size: 16)).padding(.bottom)
                
                //Contact developer button
                Button(action: {
                    if MFMailComposeViewController.canSendMail() {
                        self.isShowingMailView.toggle()
                    } else {
                        print("Can't send emails from this device")
                    }
                    if result != nil {
                        print("Result: \(String(describing: result))")
                    }
                }) {
                    HStack {
                        Image(systemName: "envelope").foregroundColor(.yellow)
                        Text("Contact Developer").foregroundColor(.yellow)
                    }
                }
                .sheet(isPresented: $isShowingMailView) {
                    MailView(result: $result) { composer in
                        composer.setSubject("Vandy COVID Tracker: App Feedback")
                        composer.setToRecipients(["samblum17@icloud.com"])
                    }
                }
            }.padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            .navigationBarHidden(true)
            .navigationBarTitle(Text(""))
        }
        }.navigationViewStyle(StackNavigationViewStyle())

    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}

//Note that Unlocalized, hardcoded strings were used to display text for a primarily English audience. Future updates could push with localized versions
