//
//  ContentView.swift
//  ClockWithSeconds
//
//  Created by John Holland on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("is24Hour") private var is24HourStorage = false
    @State private var bgColor:Color = .black
    @State private var fgColor:Color = .white
    @State private var currentTime: String = "00:00:00"
    @State private var amPm: String = "AM"
  

     func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat =  is24HourStorage ? "H:mm:ss" : "h:mm:ss"
        
        return formatter.string(from: Date())
        
        //.replacingOccurrences(of: "0", with: "O")
    }
    static func getAmPm() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter.string(from: Date())
    }
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.currentTime = getCurrentTime()
            self.amPm = ContentView.getAmPm()
        }
    }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color(bgColor)
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        Text("\(currentTime)")
                            .foregroundColor(fgColor)
                            .font(.custom("Helvetica Neue",size: min(geometry.size.width, geometry.size.height) / 2))
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                        //     .multilineTextAlignment(.center)
                            .background(bgColor)
                            .onAppear(perform: startTimer)
                        
                        if !is24HourStorage {
                            
                            
                            HStack {
                                Spacer()
                                Text(amPm)
                                    .foregroundColor(fgColor)
                                    .font(.custom("Helvetica Neue",size: min(geometry.size.width, geometry.size.height) / 10))
                                    .minimumScaleFactor(0.1)
                                    .fontWeight(.heavy)
                                    .lineLimit(1)
                                
                                    .multilineTextAlignment(.trailing)
                                    .background(bgColor)
                            }
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "gearshape")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(fgColor)
                            }
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView: View {
    
@AppStorage("is24Hour") private var settingsIs24Hour: Bool = false

    var body: some View {
        Text("Settings")
            .font(.largeTitle)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        Toggle("24 Hour:", isOn: $settingsIs24Hour)
            

        
    }
}


#Preview {
    ContentView()
}
