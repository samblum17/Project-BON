//
//  ContentView.swift
//  Project BON
//
//  Created by Sam Blum on 1/29/21.
//

import SwiftUI

struct MainDataView: View {
    @State private var positivityRate: String = "0.00"
    
    var body: some View {
        Text("\(positivityRate)")
            .padding()
            .onAppear{
                fetchPositivityRate(completion: { (retrievedData) in
                    positivityRate = retrievedData?.nestedData?.first?.first ?? "0.00"
                })
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainDataView()
    }
}

