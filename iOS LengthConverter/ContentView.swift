// Published by RafaelSwi on Github (August 13, 2022)
// Release 1.0 (August 13, 2022)

import SwiftUI

struct ContentView: View {
    
    enum options: String {
        case meters = "m"
        case kilometers = "Km"
        case feet = "ft"
        case yards = "yd"
        case miles = "mi"
        case nothing = ""
    }
    
    let optionOrganization: [options] = [.meters, .kilometers, .feet, .yards, .miles]
    
    @State private var selectedSender: options = .nothing
    @State private var selectedDestination: options = .nothing
    
    @State private var amountSender: Float = 0.0
    @State private var amountDestination: Float = 0.0
    
    @State private var DestionationDisplay = ""
    
    @FocusState private var typingFocused: Bool
    
    func Convert (value: Float, from: options, to: options) {
        
        var result = value
        
        switch from {
        case .nothing: break
        case .meters: result = value
        case .kilometers: result = (value * 1000)
        case .feet: result = (value / 3.281)
        case .yards: result = (value / 1.094)
        case .miles: result = (value * 1609)
        }
        
        switch to {
        case .nothing: break
        case .meters: amountDestination = result
        case .kilometers: amountDestination = (result / 1000)
        case .feet: amountDestination = (result * 3.281)
        case .yards: amountDestination = (result * 1.094)
        case .miles: amountDestination = (result / 1609)
        }
        
        DestionationDisplay = ""
        DestionationDisplay += "\(amountDestination)"
        if (from == .nothing && to != .nothing)
        {DestionationDisplay = "choose a length unit first"}
        
    }
    
    func informativeText (Length: options) -> String {
        
        switch Length {
        case .meters:
            return "meters"
        case .kilometers:
            return "kilometers"
        case .feet:
            return "feet"
        case .yards:
            return "yards"
        case .miles:
            return "miles"
        case .nothing:
            return "..."
        }
        
    }
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .ignoresSafeArea()
                .gradientForeground(colors: [.yellow, .orange])
            
            VStack {
                
                Text ("LengthConverter")
                    .foregroundColor(.black)
                    .font(.system(size:40).bold())
                
                Text ("Published by RafaelSwi on Github")
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black.opacity(0.5))
                    .font(.callout)
                
                Spacer()
                    .frame(width: 90, height: 205)
                
                VStack {
                    
                    VStack {
                        
                        TextField ("Amount", value: $amountSender, format: .number)
                            .keyboardType(.numberPad)
                            .frame(width: 230, height: 35)
                            .background(.black.opacity(0.2))
                            .cornerRadius(30)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.callout)
                            .focused($typingFocused)
                        
                        Picker ("Options", selection: $selectedSender) {
                            
                            ForEach (optionOrganization, id: \.self) { button in
                                
                                Text ("\(button.rawValue)")
                                
                            }
                        } .pickerStyle(.segmented)
                    }
                    
                    Text (informativeText(Length: selectedSender))
                        .foregroundColor(.gray.opacity(0.5))
                        .font(.system(size:13))
                    
                    Spacer ()
                        .frame(width: 90, height: 40)
                    
                    HStack {
                        
                        Image ("arrow_down")
                            .resizable()
                            .frame(width: 15, height: 60)
                            .clipped()
                            .offset(x: 8, y: 0)
                        
                        Button("CONVERT") {
                            Convert(value: amountSender, from: selectedSender, to: selectedDestination)
                        } .font(.title2.bold())
                            .foregroundColor(.black)
                        
                        
                    }
                    
                    Spacer ()
                        .frame(width: 90, height: 40)
                    
                    VStack {
                        
                        Text (informativeText(Length: selectedDestination))
                            .foregroundColor(.black.opacity(0.5))
                            .font(.system(size:13))
                        
                        Picker ("Options", selection: $selectedDestination) {
                            
                            ForEach (optionOrganization, id: \.self) { button in
                                
                                Text ("\(button.rawValue)")
                                
                            }
                        } .pickerStyle(.segmented)
                        
                        Text ("\(DestionationDisplay)")
                            .frame(width: 230, height: 35)
                            .background(.black.opacity(0.5))
                            .cornerRadius(30)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.callout)
                        
                    }
                }
            }
            
        } .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button ("Done") {
                    typingFocused = false
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    public func gradientForeground (colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(self)
        
    }
}
