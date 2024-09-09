//
//  MonetView.swift
//  Galerie (en français cette fois ci)
//
//  Created by goldorak on 12/09/2023.
//

import SwiftUI

struct MonetView: View {
    var body: some View {
        VStack{
            Image("monet")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Claude Monet")
        }

    }
}


struct MonetView_Previews: PreviewProvider {
    static var previews: some View {
        MonetView()
    }
}
