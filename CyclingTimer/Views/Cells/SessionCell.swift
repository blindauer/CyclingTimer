//
//  SessionCell.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-08.
//

import Foundation
import SwiftUI

struct SessionCell: View {
    var session: Session
    
    var body: some View {
        let set = session.segments[0].sets[0] // TODO: if session is resuming keep track of progress, otherwise start from the beggining
        let setViewModel = SetViewModel(set: set)
        let sessionDetail = SessionDetail(session: session, setViewModel: setViewModel)
        
        NavigationLink(destination: sessionDetail) {
            VStack(alignment: .leading) {
                Text(session.name)
                Text(session.durationLabel)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
        }
    }
}
