//
//  SwiftUIView.swift
//  JsonTest
//
//  Created by ksnowlv on 2024/9/22.
//

import SwiftUI

struct SwiftUIView: View {
    
    
    var body: some View {
        
        VStack(){
            
            Text("---UIKit call SwiftUI---")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,10)
                .padding(.leading,10)
            
            Text("SwiftUIView as UIView in UIKit")
                .font(.system(size: 17))
                .foregroundColor(.black)
                .padding(.top, 30)
                .padding(.bottom,10) //
            
        }.background(Color.purple)
           
    }
}

#Preview {
    SwiftUIView()
}
