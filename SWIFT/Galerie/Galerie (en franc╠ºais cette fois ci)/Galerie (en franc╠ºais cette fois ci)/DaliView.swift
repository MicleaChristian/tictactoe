//
//  DaliView.swift
//  Galerie (en français cette fois ci)
//
//  Created by goldorak on 12/09/2023.
//

import SwiftUI

struct DaliView: View {
    var body: some View {
        VStack{
            Image("dali")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Salvador Dali")
        }

    }
}

struct DaliView_Previews: PreviewProvider {
    static var previews: some View {
        DaliView()
    }
}
