//
//  PokemonDetailView.swift
//  PokedexSwiftUI
//
//  Created by user216592 on 4/11/22.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    var pokemon: Pokemon
    @State private var scale: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text(pokemon.type.capitalized)
                    .italic()
                    .foregroundColor(pokemon.typeColor)
                
                PokemonImage(image: KFImage(URL(string: pokemon.imageURL)))
                    .padding(.bottom, -100)
                    .zIndex(1)
                
                ZStack {
                    Rectangle()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .foregroundColor(pokemon.typeColor)
                    
                    VStack {
                        if pokemon.isFavorite {
                            Label("Favorite", systemImage: "star.fill")
                                .foregroundColor(.white)
                                .padding()
                                .background(Capsule().foregroundColor(.yellow.opacity(0.8)))
                        }
                        
                        Text(pokemon.description.replacingOccurrences(of: "\n", with: ""))
                            .foregroundColor(.white)
                            .padding()
                        
                        StatsViewGroup(pokemon: pokemon)
                    }
                    .offset(y: -40)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.spring()) {
                            scale = 1
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: PokemonViewModel().MOCK_POKEMON)
    }
}
