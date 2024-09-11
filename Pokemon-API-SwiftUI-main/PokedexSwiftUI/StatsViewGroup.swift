//
//  StatsViewGroup.swift
//  PokedexSwiftUI
//
//  Created by user216592 on 4/11/22.
//

import SwiftUI

import SwiftUI

struct StatsViewGroup: View {
    var pokemon: Pokemon
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 250)
                .foregroundColor(.white)
                .opacity(0.8)
                .cornerRadius(20)
            VStack(alignment: .leading, spacing: 30) {
                StatView(pokemon: pokemon, statName: "ATK", statColor: .blue, statValue: pokemon.attack)
                StatView(pokemon: pokemon, statName: "DEF", statColor: .red, statValue: pokemon.defense)
                StatView(pokemon: pokemon, statName: "HGT", statColor: .teal, statValue: pokemon.height)
                StatView(pokemon: pokemon, statName: "WGT", statColor: .cyan, statValue: pokemon.weight)
            }
        }
    }
}

struct StatView: View {
    var pokemon: Pokemon
    var statName: String
    var statColor: Color
    var statValue: Int
    
    var body: some View {
        HStack {
            Text(statName)
                .font(.system(.body, design: .monospaced))
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(width: 150, height: 20)
                
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(statColor)
                    .frame(width: min(150 * (CGFloat(statValue) / 100), 150), height: 20)
            }
            Text("\(statValue)")
                .font(.system(.body, design: .monospaced))
        }
    }
}

struct StatsViewGroup_Previews: PreviewProvider {
    static var previews: some View {
        StatsViewGroup(pokemon: PokemonViewModel().MOCK_POKEMON)
    }
}
