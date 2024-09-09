import SwiftUI

struct ContentView: View {
    @State private var isContactInfoVisible = false // Set to false to hide info by default

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Spacer()
                
                Image("miclea")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .padding(.bottom, 20)
                
                Text("MICLEA Christian")
                    .font(.system(size: 18, weight: .bold))
                
                Text("Developpeur Fullstack junior")
                    .font(.system(size: 14, weight: .thin))
                    .foregroundColor(.gray)
                
                // Conditional view based on the toggle state
                if isContactInfoVisible {
                    HStack(alignment: .center) {
                        Text("Email:")
                            .font(.system(size: 14, weight: .thin))
                            .foregroundColor(.gray)
                        
                        Text("christian.miclea@hotmail.com")
                            .font(.system(size: 14, weight: .thin))
                            .foregroundColor(.green)
                    }
                    
                    HStack(alignment: .center) {
                        Text("Tel:")
                            .font(.system(size: 14, weight: .thin))
                            .foregroundColor(.gray)
                        
                        Text("06 63 43 35 69")
                            .font(.system(size: 14, weight: .thin))
                            .foregroundColor(.gray)
                    }
                }
                
                // Toggle button to hide/show contact info
                Button(action: {
                    isContactInfoVisible.toggle()
                }) {
                    Text(isContactInfoVisible ? "Hide Contact Info" : "Show Contact Info")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.green)
                }
                
                Spacer()
            }
            .padding()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 320, height: 640)
    }
}
