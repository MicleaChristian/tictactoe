import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: MonetView()) {
                    Text("Monet")
                        .font(.largeTitle)
                        .padding()
                }
                
                NavigationLink(destination: VanGoghView()) {
                    Text("Van Gogh")
                        .font(.largeTitle)
                        .padding()
                }
                
                NavigationLink(destination: DaliView()) {
                    Text("Dali")
                        .font(.largeTitle)
                        .padding()
                }
            }
            .navigationBarTitle("GALERIE D'ART")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
