//
//  ContentView.swift
//  Project BON
//
//  Created by Sam Blum on 1/29/21.
//

import SwiftUI

//The main UI view with COVID-19 data from the most recent week
struct MainDataView: View {
    @State private var positivityRate: String = "Loading..."
    @State private var numPositives: String = "Loading..."
    @State private var trend: String = "Loading..."
    @State private var week: String = "Loading..."
    @State private var trendColor: Color = .green //green for decrease in cases, red for increase in cases
    @State private var showingRefreshAlert = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.black.ignoresSafeArea()
                //Overarching Vstack
                VStack(alignment: .leading){
                    Image("CoverLogo").resizable().scaledToFit()
                        .padding(.bottom)
                        .padding(.bottom)
                    //Text VStack
                    VStack(alignment: .leading){
                        Text("Week of \(week)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .onAppear{
                                fetchWeek(completion: { (retrievedData) in
                                    week = retrievedData
                                })
                            }
                            .padding(.bottom)
                        //Num positives
                        Text("\(numPositives)")
                            .foregroundColor(.yellow)
                            .font(.system(size: 70))
                            .onAppear{
                                fetchNumPositives(completion: { (retrievedData) in
                                    numPositives = retrievedData
                                })
                            }
                        Text("positive results")
                            .foregroundColor(.white)
                            .padding(.bottom)
                            .padding(.bottom)
                        Text("\(positivityRate)")
                            .foregroundColor(.yellow)
                            .font(.system(size: 60))
                            .onAppear{
                                fetchPositivityRate(completion: { (retrievedData) in
                                    let temp = retrievedData
                                    positivityRate = temp
                                })
                            }
                        //Positivity rate
                        Text("positivity rate")
                            .foregroundColor(.white)
                            .padding(.bottom)
                            .padding(.bottom)
                        
                        //Trends
                        Text("\(trend)%")
                            .foregroundColor(trendColor)
                            .font(.system(size: 60))
                            .onAppear{
                                fetchTrend(completion: { (retrievedData) in
                                    var trendRate = Double(retrievedData.dropLast()) ?? 0.00
                                    trendRate = trendRate.truncate(places: 2)
                                    if (trendRate >= 0){
                                        trend = "+\(trendRate)"
                                        trendColor = .red
                                    } else {
                                        trend = "\(trendRate)"
                                        trendColor = .green
                                    }
                                })
                            }
                        Text("week-over-week positivity rate trend")
                            .foregroundColor(.white)
                            .padding(.bottom)
                            .padding(.bottom)
                        
                        //Bottom HStack buttons
                        Spacer()
                        HStack{
                            Button(action: {
                                reloadData()
                                self.showingRefreshAlert = true
                            }, label: {
                                HStack {
                                    Image(systemName: "arrow.clockwise.circle").resizable() .frame(width: 30, height: 30, alignment: .leading).foregroundColor(.yellow)
                                    Text("Refresh").foregroundColor(.yellow)
                                }
                            }).alert(isPresented: $showingRefreshAlert) {
                                Alert(title: Text("Data Refreshed"), message: Text("Vandy COVID Tracker is now up-to-date with the most recent data available."), dismissButton: .default(Text("Ok")))
                            }
                            
                            Spacer()
                            NavigationLink(destination: Help(), label: {
                                Image(systemName: "questionmark.circle").resizable()
                                    .frame(width: 30, height: 30, alignment: .leading)
                                    .foregroundColor(.init(UIColor.systemGray))
                            })
                            .navigationBarHidden(true)
                        }
                    }.padding(.leading)
                    .padding(.trailing)
                }
            }
        }
    }
    
    //Refresh button tapped
    func reloadData() {
        fetchNumPositives(completion: { (retrievedData) in
            numPositives = retrievedData
        })
        fetchPositivityRate(completion: { (retrievedData) in
            let temp = retrievedData
            positivityRate = temp
        })
        fetchTrend(completion: { (retrievedData) in
            var trendRate = Double(retrievedData.dropLast()) ?? 0.00
            trendRate = trendRate.truncate(places: 2)
            if (trendRate >= 0){
                trend = "+\(trendRate)"
                trendColor = .red
            } else {
                trend = "\(trendRate)"
                trendColor = .green
            }
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainDataView()
    }
}

//For truncating
extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
