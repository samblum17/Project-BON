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
    
    var body: some View {
        ZStack{
            VStack{
                Text("\(positivityRate)")
                    .onAppear{
                        fetchPositivityRate(completion: { (retrievedData) in
                            positivityRate = retrievedData?.nestedData?.first?.first ?? "0.00"
                        })
                    }
                Text("\(numPositives)")
                    .padding()
                    .onAppear{
                        fetchNumPositives1(completion: { (retrievedData) in
                            fetchNumPositives2(completion: {(retrievedData2) in
                                let temp = (retrievedData ?? 0) + (retrievedData2 ?? 0)
                                numPositives = "\(temp)"
                            })
                        })
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

