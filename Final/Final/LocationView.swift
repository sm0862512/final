//
//  LocationView.swift
//  Final
//
//  Created by BALLARD, MATTHEW J. on 4/29/24.
//

import SwiftUI

struct LocationView: View {
    var body: some View {
        Color.black
            .edgesIgnoringSafeArea(.all)
            .overlay(
                NavigationLink(destination: ContentView()) {
                    ZStack {
                        Image("mars-11012_1280")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 600, height: 300)
                        
                        Image("MarsRover2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .onHover(perform: { hovering in
                                   // Image("MarsRover2")
                                    
                                
                            })
                            
                    }
                }
            )
    }
}

#Preview {
    LocationView()
}
