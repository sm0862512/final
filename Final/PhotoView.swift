//
//  PhotoView.swift
//  PhotoView
//
//  Created by SANDERS, CADEN P. on 4/29/24.
//

import SwiftUI





struct PhotoView: View {
    var body: some View {
        Color.black
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
            .overlay{
                
                HStack(alignment: .center){
                    
                    Text("All Photos")
                        .foregroundStyle(Color.white)
                        .font(.title)
                        .bold()
                    //.padding()
                        .offset(y:-350)
                    
                    
                    Button("View Timeplase") {
                        let viewController = ViewController()
                        viewController.viewDidLoad()
                        // Call a function
                        print(viewController.imageData as Any) // Access a variable


                    }
                    .background(Color.white)
                    .foregroundColor(.black)
                    //.padding(50)
                    .offset(y: -350)
                    .frame(width: 200, height: 50)
                    .buttonStyle(.bordered)
                }
               
                ScrollView{
                    //Array of photos when API can be called
                }
            }
        
        
        
        
        
        
    }
}

#Preview {
    PhotoView()
}
