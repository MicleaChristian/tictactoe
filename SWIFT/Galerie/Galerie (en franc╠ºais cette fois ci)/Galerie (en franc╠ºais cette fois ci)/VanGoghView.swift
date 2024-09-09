//
//  VanGoghView.swift
//  Galerie (en français cette fois ci)
//
//  Created by goldorak on 12/09/2023.
//

import SwiftUI

struct VanGoghView: View {
    var body: some View {
        VStack{
            Image("van gogh")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Vincent Van Gogh")
        }

    }
}

struct VanGoghView_Previews: PreviewProvider {
    static var previews: some View {
        VanGoghView()
    }
}
