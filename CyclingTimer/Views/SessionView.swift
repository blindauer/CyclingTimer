//
//  SessionView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-08.
//

import Foundation
import SwiftUI

struct SessionView: View {
    let session: Session
    
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

struct SessionView_Previews: PreviewProvider {
    static var session = Session.data[0]
    static var previews: some View {
        Group {
            SessionView(session: session)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
