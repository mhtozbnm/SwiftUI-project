//
//  CustomButtons.swift
//  onlinesanalstoreSwiftUI
//
//  Created by Mahmut on 5.05.2024.
//

import SwiftUI

struct RoundBtn: View {
    
    @State var title: String = ""
    var didTap: (() -> ())?
    
    var body: some View {
        Button {
            didTap?()
        } label: {
            Text(title)
                .font(.title)
                .foregroundStyle(.bar)
                .multilineTextAlignment(.center)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        .background(Color.primaryApp)
        .cornerRadius(30)
    }
}

#Preview {
    RoundBtn()
}
