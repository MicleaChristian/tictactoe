import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ScrollView {
            VStack(alignment: .center) {
                Spacer()
                
                Text("GALERIE D'ART")
                    .font(.largeTitle)
                    .padding()
                
                
                    
            }
            
        NavigationView {
            VStack {
                NavigationLink(destination: ArtistDetailView(artist: "Monet")) {
                    Text("Monet")
                        .font(.largeTitle)
                        .padding()
                }
                
                NavigationLink(destination: ArtistDetailView(artist: "Van Gogh")) {
                    Text("Van Gogh")
                        .font(.largeTitle)
                        .padding()
                }
                
                NavigationLink(destination: ArtistDetailView(artist: "Dali")) {
                    Text("Dali")
                        .font(.largeTitle)
                        .padding()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            // Set the window title here
            NSApp.mainWindow?.title = "Artists Gallery"
        }
    }
}

struct ArtistDetailView: View {
    let artist: String
    
    var body: some View {
        Text("Detail view for \(artist)")
            .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
