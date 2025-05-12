//
//  ListView.swift
//  ReGo
//
//  Created by  서재효 on 5/12/25.
//

import SwiftUI

struct ListView: View {
    

    var body: some View {

        NavigationStack {
            VStack(alignment: .leading) {
                Text("List")
                    .font(.largeTitle)
                    .bold()
                    .padding()


                
            }
        }
        .toolbar {
            ToolbarItem {
                Image(systemName: "plus")
            }
        }
    }
}

#Preview {
    ListView()
}
