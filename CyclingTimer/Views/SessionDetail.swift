//
//  SessionDetail.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-27.
//

import SwiftUI

struct SessionDetail: View {
    
    private var session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    
    var body: some View {
        TimerView()
    }
}

struct SessionDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SessionDetail(session: testStore.sessions[0])
        }
    }
}
