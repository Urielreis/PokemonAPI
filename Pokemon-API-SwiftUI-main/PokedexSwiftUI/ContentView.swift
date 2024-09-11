//
//  ContentView.swift
//  PokedexSwiftUI
//
//  Created by user216592 on 4/11/22.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @ObservedObject var pokemonVM = PokemonViewModel()
    @State private var searchText = ""
    
    var filteredPokemon: [Pokemon] {
        if searchText.isEmpty { return pokemonVM.pokemon }
        return pokemonVM.pokemon.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            if pokemonVM.pokemon.isEmpty {
                ProgressView("Carregando Pokémon...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .padding()
            } else {
                List {
                    ForEach(filteredPokemon) { poke in
                        NavigationLink(destination: PokemonDetailView(pokemon: poke)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Text(poke.name.capitalized)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        if poke.isFavorite {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                        }
                                    }
                                    
                                    HStack {
                                        Text(poke.type.capitalized)
                                            .italic()
                                            .foregroundColor(.gray)
                                        Circle()
                                            .foregroundColor(poke.typeColor)
                                            .frame(width: 10, height: 10)
                                    }
                                    Text(poke.description)
                                        .font(.subheadline)
                                        .lineLimit(1)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                KFImage(URL(string: poke.imageURL))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                    .shadow(radius: 4)
                            }
                        }
                        .swipeActions {
                            Button(action: { addFavorite(pokemon: poke) }) {
                                Image(systemName: "star")
                            }
                            .tint(.yellow)
                        }
                    }
                }
                .navigationTitle("Pokémon")
                .searchable(text: $searchText)
                .listStyle(PlainListStyle())
                .background(Color(UIColor.systemGroupedBackground))
            }
        }
    }
    
    func addFavorite(pokemon: Pokemon) {
        if let index = pokemonVM.pokemon.firstIndex(where: { $0.id == pokemon.id }) {
            withAnimation(.easeInOut) {
                pokemonVM.pokemon[index].isFavorite.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
