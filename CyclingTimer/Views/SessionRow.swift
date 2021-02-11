//
//  SessionRow.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-08.
//

import Foundation
import SwiftUI

struct SessionRow: View {
    var session: Session
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(session.name)
            Text(session.durationLabel)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
    }
}

struct SessionCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SessionRow(session: testStore.sessions[0])
            SessionRow(session: testStore.sessions[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
