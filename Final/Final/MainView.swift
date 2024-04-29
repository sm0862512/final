//
//  MainView.swift
//  Final
//
//  Created by BALLARD, MATTHEW J. on 4/29/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        NavigationLink(destination: ContentView()) {
                            ZStack {
                                Image("TopImage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 300)
                            }
                        }
                        
                        Text("A Month on Mars")
                            .foregroundColor(.orange)
                            .font(.custom("Avenir Next", size: 24))
                            .fontWeight(.bold)
                        
                        NavigationLink(destination: ContentView()) {
                            ZStack {
                                Image("MarsHorizon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 600, height: 300) 
                            }
                        }
                    }
                )
        }
    }
}





#Preview {
    MainView()
}
