//
//  File.swift
//  KeepInTouch
//
//  Created by ikorobov on 12.09.2023.
//

import SwiftUI

extension View {
    
    func popupNavigationView<Content: View>(isPresented: Binding<Bool>, horizontalPadding: CGFloat, verticalPadding: CGFloat, cornerRadius: CGFloat, @ViewBuilder content: @escaping () -> Content) -> some View {
        return self
        
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay {
                if isPresented.wrappedValue {
                    GeometryReader { proxy in
                        let size = proxy.size
                        
                        Color.black.opacity(0.1).ignoresSafeArea()
                        
                        NavigationView {
                            content()
                                .background(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .foregroundColor(.white)
                                )
                        }
                        .frame(width: size.width - horizontalPadding, height:  size.height - (verticalPadding * 2), alignment: .center)
                        .cornerRadius(cornerRadius)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center )
                    }
                }
            }
        
    }
}

//    // Display popup modifier
//struct Popup<T: View>: ViewModifier {
//    let popup: T
//    let alignment: Alignment
//    let direction: Direction
//    let isPresented: Bool
//    
//    //modifier init
//    
//    init(isPresented: Bool, alignment: Alignment, direction: Direction, @ViewBuilder content: () -> T) {
//        self.isPresented = isPresented
//        self.alignment = alignment
//        self.direction = direction
//        popup = content()
//    }
//    
//    //modifying method
//    func body(content: Content) -> some View {
//        content
//            .overlay(popupContent())
//    }
//    
//    //displaying popup content
//    @ViewBuilder
//    private func popupContent() -> some View {
//        GeometryReader { geometry in
//            if isPresented {
//                NavigationView {
//                    popup
//                        .animation(.spring(), value: 1)
//                        .transition(.offset(x: 0, y: direction.offset(popupFrame: geometry.frame(in: .global))))
//                        .cornerRadius(15)
//                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
//                    
//                }
//            }
//        }
//    }
//}
//
//
////direction defenition
//extension Popup {
//    enum Direction {
//        case top, bottom
//        
//        //calculationg offsets
//        func offset(popupFrame: CGRect) -> CGFloat {
//            switch self {
//                case .top:
//                    let aboveScreenEdge = -popupFrame.maxY
//                    return aboveScreenEdge
//                    
//                case .bottom:
//                    let belowScreenEdge = UIScreen.main.bounds.height - popupFrame.minY
//                    return belowScreenEdge
//            }
//        }
//    }
//}
//
////View extention to applying modifier
//extension View {
//    func popup<T: View>(isPresented: Bool, alignment: Alignment = .center, direction: Popup<T>.Direction = .bottom, @ViewBuilder content: () -> T) -> some View {
//        return modifier(Popup(isPresented: isPresented, alignment: alignment, direction: direction, content: content))
//    }
//}
//
////global frame changing tracker
//private extension View {
//    func onGlobalFrameChange(_ onChange: @escaping (CGRect) -> Void) -> some View {
//        background(GeometryReader { geometry in
//            Color.clear.preference(key: FramePreferenceKey.self , value: geometry.frame(in: .global))
//        })
//        .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
//    }
//}
//
//
//private struct FramePreferenceKey: PreferenceKey {
//    static let defaultValue = CGRect.zero
//    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
//        value = nextValue()
//    }
//}
//
//private extension View {
//    @ViewBuilder func applyIf<T: View>(_ condition: @autoclosure () -> Bool, apply: (Self) -> T) -> some View {
//        if condition() {
//            apply(self)
//        } else {
//            self
//        }
//    }
//}
