//
//  TimerBootcamp.swift
//  CoreDataBootcamp
//
//  Created by Frank Bara on 12/22/21.
//

import SwiftUI

struct TimerBootcamp: View {
    
    // create a timer to publish over time (this is actually a publisher)
    let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    
    // Current time
    /*
     @State var currentDate: Date = Date()
     
     var dateFormatter: DateFormatter {
     let formatter = DateFormatter()
     formatter.timeStyle = .medium
     formatter.dateStyle = .short
     return formatter
     }
     */
    
    // Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
     */
    
    // Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
//        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(minute) minutes, \(second) seconds"
    }
     */
    
    // Animation counter
    @State var count: Int = 1
    
    var body: some View {
        
        ZStack {
            RadialGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]),
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
                .ignoresSafeArea()
            
//            Text(timeRemaining)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
            
//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//
//            }
//            .frame(width: 150)
//            .foregroundColor(.white)
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(4)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer, perform: { _ in
//            updateTimeRemaining()
            withAnimation(.default) {
                count = count == 4 ? 0 : count + 1
            }
            
        })
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
