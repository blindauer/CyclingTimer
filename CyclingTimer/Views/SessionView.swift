//
//  SessionDetail.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-27.
//

import SwiftUI

struct SessionView: View {
    
    private var session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    
    var body: some View {
        Clock()
        Spacer()
        ZStack {
            PlayPauseButton()
            LineTimer()
        }
        Spacer()
    }
}

struct SessionDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SessionView(session: testStore.sessions[0])
        }
    }
}
