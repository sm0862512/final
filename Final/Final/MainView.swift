import SwiftUI

struct MainView: View {
    @State private var showPointer = false
    
    var body: some View {
        NavigationView {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        NavigationLink(destination: LocationView()) {
                            ZStack {
                                Image("TopImage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 300)
                            }
                        }
                        
                        Text("Curiosity")
                            .foregroundColor(.orange)
                            .font(.custom("Avenir Next", size: 24))
                            .fontWeight(.bold)
                        
                        NavigationLink(destination: LocationView()) {
                            ZStack {
                                Image("MarsHorizon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 600, height: 300)
                                    .overlay(
                                        // Finger pointer icon
                                        Image(systemName: "hand.point.up.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 40))
                                            .opacity(showPointer ? 1 : 0)
                                            .onAppear {
                                                // Start pulsating animation after 5 seconds
                                                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
                                                    withAnimation {
                                                        self.showPointer.toggle()
                                                    }
                                                }
                                            }
                                            .padding(.bottom, 20)
                                    )
                            }
                        }
                    }
                )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
