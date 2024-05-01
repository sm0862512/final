import SwiftUI

struct PhotoView: View {
    var imageData: String = ""

    func someFunction(imageData: String) {
        // Here you can use imageData
        print(imageData)
    }

    var body: some View {
        Color.black
            .edgesIgnoringSafeArea(.all)
            .overlay{
                HStack(alignment: .center){
                    Text("All Photos")
                        .foregroundStyle(Color.white)
                        .font(.title)
                        .bold()
                        .offset(y:-350)
                    
                    Button("View Timeplase") {
                        someFunction(imageData: imageData)
                    }
                    .background(Color.white)
                    .foregroundColor(.black)
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
