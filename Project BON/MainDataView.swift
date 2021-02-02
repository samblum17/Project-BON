//
//  ContentView.swift
//  Project BON
//
//  Created by Sam Blum on 1/29/21.
//

import SwiftUI

//The main UI view with COVID-19 data from the most recent week
struct MainDataView: View {
    @State private var positivityRate: String = "loading..."
    @State private var numPositives: String = "loading..."
    @State private var trend: String = "loading..."
    @State private var week: String = "loading..."
    @State private var trendColor: Color = .green //green for decrease in cases, red for increase in cases
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.black.ignoresSafeArea()
                //Overarching Vstack
                VStack(alignment: .leading){
                    Image("Pic2").resizable().scaledToFit()
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
                                fetchNumPositives1(completion: { (retrievedData) in
                                    numPositives = "\(retrievedData ?? 0)"
                                })
                            }
                        Text("positive results")
                            .foregroundColor(.white)
                            .padding(.bottom)
                            .padding(.bottom)
                        Text("\(positivityRate)%")
                            .foregroundColor(.yellow)
                            .font(.system(size: 60))
                            .onAppear{
                                fetchPositivityRate1(completion: { (retrievedData) in
                                    var temp = retrievedData
                                    temp = temp.truncate(places: 2)
                                    positivityRate = String(temp)
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
                                fetchPositivityRate1(completion: { (retrievedData) in
                                    fetchPositivityRate2(completion: {(retrievedData2) in
                                        let temp = Double(positivityRate) ?? 0.00
                                        let temp2 = (retrievedData2)
                                        var trendRate = Double(temp - temp2)
                                        trendRate = trendRate.truncate(places: 2)
                                        if (trendRate > 0){
                                            trend = "+\(trendRate)"
                                            trendColor = .red
                                        } else {
                                            trend = "\(trendRate)"
                                            trendColor = .green
                                        }
                                    })
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
                            }, label: {
                                HStack {
                                    Image(systemName: "arrow.clockwise.circle").resizable() .frame(width: 30, height: 30, alignment: .leading).foregroundColor(.yellow)
                                    Text("Refresh").foregroundColor(.yellow)
                                }
                            })
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
    
    func reloadData() {
        fetchNumPositives1(completion: { (retrievedData) in
            numPositives = "\(retrievedData ?? 0)"
        })
        fetchPositivityRate1(completion: { (retrievedData) in
            var temp = retrievedData
            temp = temp.truncate(places: 2)
            positivityRate = String(temp)
        })
        fetchPositivityRate1(completion: { (retrievedData) in
            fetchPositivityRate2(completion: {(retrievedData2) in
                let temp = Double(positivityRate) ?? 0.00
                let temp2 = (retrievedData2)
                var trendRate = Double(temp - temp2)
                trendRate = trendRate.truncate(places: 2)
                if (trendRate > 0){
                    trend = "+\(trendRate)"
                    trendColor = .red
                } else {
                    trend = "\(trendRate)"
                    trendColor = .green
                }
            })
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
