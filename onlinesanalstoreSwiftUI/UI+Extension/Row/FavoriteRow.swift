//
//  FavoriteRow.swift
//  onlinesanalstoreSwiftUI
//
//  Created by Mahmut on 7.05.2024.
//

import SwiftUI

struct FavoriteRow: View {
    
    let products: Product
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                Image(products.image)
                    .resizable()
                    .transition(.opacity)
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
                VStack(spacing: 4){
                    
                    Text(products.name)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.black)
                        .frame(minWidth: 0,maxWidth: .infinity, alignment: .leading)
                    
                    Text(products.typeName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                        .frame(minWidth: 0,maxWidth: .infinity, alignment: .leading)
                    
                }
                
                Text("\(products.price) TL")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .frame(minWidth: 0,maxWidth: .infinity, alignment: .leading)
                    
                Image("next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                
                
            }
            Divider()
        }
    }
}

#Preview {
    FavoriteRow(products: MockData.sampleProduct1)
}
