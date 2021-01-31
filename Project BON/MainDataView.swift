//
//  ContentView.swift
//  Project BON
//
//  Created by Sam Blum on 1/29/21.
//

import SwiftUI

//The main UI view with COVID-19 data from the most recent week
struct MainDataView: View {
    @State private var positivityRate: String = "0.00"
    @State private var numPositives: String = "0"
    @State private var week: String = "Nov. 1"
    
    var body: some View {
        NavigationView{
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading){
                Image("ADSU").resizable().scaledToFit()
                VStack(alignment: .leading){
                    Text("Week of \(week)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .onAppear{
                            fetchWeek(completion: { (retrievedData) in
                                week = retrievedData?.nestedData?.first?.first ?? "Nov. 1"
                            })
                        }
                        .padding(.bottom)
                        .padding(.bottom)
                    Text("\(numPositives)")
                        .foregroundColor(.yellow)
                        .font(.system(size: 70))
                        .onAppear{
                            fetchNumPositives1(completion: { (retrievedData) in
                                fetchNumPositives2(completion: {(retrievedData2) in
                                    let temp = (retrievedData ?? 0) + (retrievedData2 ?? 0)
                                    numPositives = "\(temp)"
                                })
                            })
                        }
                    Text("undergraduate positive results")
                        .foregroundColor(.white)
                        .padding(.bottom)
                        .padding(.bottom)
                    Text("\(positivityRate)")
                        .foregroundColor(.yellow)
                        .font(.system(size: 60))
                        .onAppear{
                            fetchPositivityRate(completion: { (retrievedData) in
                                positivityRate = retrievedData?.nestedData?.first?.first ?? "0.00"
                            })
                        }
                    Text("campus-wide positivity rate")
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination: Help(), label: {
                        Image(systemName: "questionmark.circle").resizable()
                            .frame(width: 30, height: 30, alignment: .leading)
                            .foregroundColor(.init(UIColor.systemGray))
                    })
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                }.padding(.leading)
            }
        }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainDataView()
    }
}

