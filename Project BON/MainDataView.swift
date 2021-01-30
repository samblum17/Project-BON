//
//  ContentView.swift
//  Project BON
//
//  Created by Sam Blum on 1/29/21.
//

import SwiftUI

struct MainDataView: View {
    @State private var positivityRate: String = "0.00"
    @State private var numPositives: String = "0"
    @State private var week: String = "Nov. 1"
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack{
                Image("ADSU").resizable().scaledToFit()
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
                    .padding(.bottom)
                VStack(alignment: .leading){
                    Text("\(numPositives)")
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
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
                    Text("\(positivityRate)")
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                        .onAppear{
                            fetchPositivityRate(completion: { (retrievedData) in
                                positivityRate = retrievedData?.nestedData?.first?.first ?? "0.00"
                            })
                        }
                    Text("campus-wide positivity rate")
                        .foregroundColor(.white)
                    Spacer()
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

