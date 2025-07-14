//#if os(iOS)
//import SwiftUI
//
//// MARK: - MainFrameView
//
//struct MainFrameView: View {
//    @State private var chatListFrame: CGRect = .zero
//
//    var body: some View {
//        ZStack {
//            ScrollView {
//                Spacer().frame(height: 80)
//
//                VStack(spacing: 16) {
//                    ForEach(0..<12) { i in
//                        ChatBlockView(index: i)
//                            .frame(height: 60)
//                    }
//                }
//                .background(
//                    GeometryReader { geo in
//                        Color.clear
//                            .onAppear {
//                                updateFrameIfValid(geo)
//                            }
//                            .onChange(of: geo.frame(in: .global)) { _ in
//                                updateFrameIfValid(geo)
//                            }
//                    }
//                )
//
//                Spacer().frame(height: 80)
//            }
//
//            VStack(spacing: 0) {
//                GeometryReader { geo in
//                    let topBoxFrame = geo.frame(in: .global)
//                    let shouldShowTopBox = topBoxFrame.isValid &&
//                                           chatListFrame.isValid &&
//                                           chatListFrame.minY < topBoxFrame.maxY
//
//                    UIFactory.makeGlassBox(
//                        height: 110,
//                        useBlur: shouldShowTopBox,
//                        blurLevel: 2,
//                        showDivider: true,
//                        dividerAtTop: false
//                    )
//                    .opacity(shouldShowTopBox ? 1 : 0)
//                    .animation(.easeInOut(duration: 0.1), value: shouldShowTopBox)
//                }
//                .frame(height: 110)
//
//                Spacer()
//
//                GeometryReader { geo in
//                    let bottomBoxFrame = geo.frame(in: .global)
//                    let shouldShowBottomBox = bottomBoxFrame.isValid &&
//                                              chatListFrame.isValid &&
//                                              bottomBoxFrame.intersects(chatListFrame)
//
//                    UIFactory.makeGlassBox(
//                        height: 82,
//                        useBlur: shouldShowBottomBox,
//                        blurLevel: 2,
//                        showDivider: true
//                    )
//                    .opacity(shouldShowBottomBox ? 1 : 0)
//                    .animation(.easeInOut(duration: 0.1), value: shouldShowBottomBox)
//                }
//                .frame(height: 82)
//            }
//            .ignoresSafeArea(edges: .vertical)
//        }
//    }
//
//    private func updateFrameIfValid(_ geo: GeometryProxy) {
//        let frame = geo.frame(in: .global)
//        if frame.isValid {
//            self.chatListFrame = frame
//        }
//    }
//    
//}
//
//// MARK: - CGRect helper
//
//extension CGRect {
//    var isValid: Bool {
//        origin.x.isFinite &&
//        origin.y.isFinite &&
//        width.isFinite &&
//        height.isFinite &&
//        !isEmpty
//    }
//}
//
//// MARK: - ChatBlockView
//
//struct ChatBlockView: View {
//    let index: Int
//    var body: some View {
//        HStack(spacing: 12) {
//            Circle()
//                .fill(Color.green)
//                .frame(width: 50, height: 50)
//                .overlay(Text("\(index + 1)").foregroundColor(.white))
//
//            Rectangle()
//                .fill(Color.white.opacity(0.3))
//                .cornerRadius(12)
//                .frame(height: 50)
//                .overlay(
//                    Text("Chat #\(index + 1)")
//                        .foregroundColor(.black)
//                        .padding(.leading, 12),
//                    alignment: .leading
//                )
//
//            Spacer()
//        }
//        .padding(.horizontal)
//    }
//}
//
//// MARK: - UIFactory
//
//class UIFactory {
//    @ViewBuilder
//    static func makeGlassBox(
//        height: CGFloat,
//        useBlur: Bool = true,
//        blurLevel: Int = 2,
//        rgba: (red: Double, green: Double, blue: Double, alpha: Double) = (255, 255, 255, 1.0),
//        showDivider: Bool = false,
//        dividerAtTop: Bool = true
//    ) -> some View {
//        GlassBoxView(
//            height: height,
//            useBlur: useBlur,
//            blurLevel: blurLevel,
//            rgba: rgba,
//            showDivider: showDivider,
//            dividerAtTop: dividerAtTop
//        )
//    }
//
//    private struct GlassBoxView: View {
//        let height: CGFloat
//        let useBlur: Bool
//        let blurLevel: Int
//        let rgba: (red: Double, green: Double, blue: Double, alpha: Double)
//        let showDivider: Bool
//        let dividerAtTop: Bool
//
//        @Environment(\.colorScheme) private var colorScheme
//
//        var body: some View {
//            let backgroundColor = Color(
//                red: rgba.red / 255,
//                green: rgba.green / 255,
//                blue: rgba.blue / 255,
//                opacity: rgba.alpha
//            )
//
//            let dividerColor = colorScheme == .dark
//                ? Color.white.opacity(0.1)
//                : Color.black.opacity(0.1)
//
//            let material: Material = {
//                switch blurLevel {
//                case 0: return .ultraThinMaterial
//                case 1: return .thinMaterial
//                case 2: return .regularMaterial
//                case 3: return .thickMaterial
//                case 4: return .ultraThickMaterial
//                default: return .ultraThinMaterial
//                }
//            }()
//
//            ZStack {
//                if useBlur {
//                    Rectangle().fill(material)
//                } else {
//                    Rectangle().fill(backgroundColor.opacity(0))
//                }
//
//                if showDivider {
//                    VStack(spacing: 0) {
//                        if dividerAtTop {
//                            Rectangle()
//                                .fill(dividerColor)
//                                .frame(height: 1)
//                            Spacer()
//                        } else {
//                            Spacer()
//                            Rectangle()
//                                .fill(dividerColor)
//                                .frame(height: 1)
//                        }
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
//            .animation(.easeInOut(duration: 0.1), value: useBlur)
//        }
//    }
//}
//
//// MARK: - UIApplication Extension
//
//extension UIApplication {
//    var bottomSafeAreaInset: CGFloat {
//        (connectedScenes.first as? UIWindowScene)?
//            .windows
//            .first { $0.isKeyWindow }?
//            .safeAreaInsets.bottom ?? 0
//    }
//}
//
//// MARK: - Preview
//
//#Preview {
//    MainFrameView()
//}
//#endif
//
