import SwiftUI
import UIKit

struct FeatureItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let symbol: String
    let tint: Color
    var enabled: Bool = false
    var available: Bool = true
}

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            NeonBackground()

            TabView(selection: $selectedTab) {
                ProxyScreen()
                    .tag(0)

                LocationScreen()
                    .tag(1)

                ModScreen()
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            VStack {
                Spacer()
                BottomTabs(selectedTab: $selectedTab)
                    .padding(.horizontal, 18)
                    .padding(.bottom, 10)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ScreenHeader: View {
    let title: String
    let subtitle: String
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Button(action: {}) {
                    HStack(spacing: 7) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.cyan)
                }
                Spacer()
            }
            .padding(.top, 10)

            Text(title)
                .font(.system(size: 26, weight: .heavy))
                .foregroundStyle(.white)

            Text(subtitle)
                .font(.system(size: 13, weight: .medium, design: .monospaced))
                .foregroundStyle(.gray)
        }
        .padding(.bottom, 18)
    }
}

struct ProxyScreen: View {
    @State private var items: [FeatureItem] = [
        .init(title: "Proxy Body", subtitle: "Full Đỏ Xoá Máu Vàng", symbol: "figure.stand", tint: .orange),
        .init(title: "Proxy Cổ V1", subtitle: "Aim Cổ Ít Lộ Hơn", symbol: "scope", tint: .yellow, enabled: true),
        .init(title: "Proxy Cổ V2", subtitle: "Vùng Cổ Máu Đỏ To Hơn, Bám Hơn", symbol: "scope", tint: .pink, enabled: true),
        .init(title: "Proxy Drag", subtitle: "Hỗ Trợ Kéo Nhẹ Tâm Lên Đỉnh Đầu", symbol: "hand.draw", tint: .cyan, available: false),
        .init(title: "Proxy Magic", subtitle: "Đạn Ma Thuật", symbol: "wand.and.stars", tint: .purple, enabled: true)
    ]

    var body: some View {
        ScreenContainer {
            ScreenHeader(title: "Free Fire Max", subtitle: "PROXY DELTA VIP")

            AssetPackStatus()

            SectionCard(title: "PROXY DELTA VIP", icon: "bolt.fill", accent: .cyan) {
                ForEach(items.indices, id: \.self) { index in
                    FeatureRow(item: $items[index])
                }
            }

            Notice(text: "Chức năng đang bảo trì, vui lòng quay lại sau.")

            LaunchButton()
                .padding(.bottom, 90)
        }
    }
}

struct LocationScreen: View {
    @State private var items: [FeatureItem] = [
        .init(title: "ESP Vị Trí", subtitle: "Hiển thị vị trí trong giao diện mô phỏng", symbol: "location.fill", tint: .cyan, enabled: true),
        .init(title: "Radar", subtitle: "Bản đồ radar thu nhỏ", symbol: "dot.scope", tint: .blue, enabled: true),
        .init(title: "Marker", subtitle: "Đánh dấu điểm trên bản đồ", symbol: "mappin.and.ellipse", tint: .purple),
        .init(title: "Distance", subtitle: "Hiển thị khoảng cách", symbol: "ruler", tint: .orange)
    ]

    var body: some View {
        ScreenContainer {
            ScreenHeader(title: "Định Vị", subtitle: "LOCATION PANEL")

            SectionCard(title: "ĐỊNH VỊ VIP", icon: "location.fill", accent: .cyan) {
                ForEach(items.indices, id: \.self) { index in
                    FeatureRow(item: $items[index])
                }
            }

            RadarPreview()
            Notice(text: "Các mục trên chỉ là giao diện mô phỏng, không can thiệp dữ liệu trò chơi.")

            LaunchButton(title: "MỞ GAME")
                .padding(.bottom, 90)
        }
    }
}

struct ModScreen: View {
    @State private var items: [FeatureItem] = [
        .init(title: "Tên Nhân Vật", subtitle: "Tuỳ chọn hiển thị nhân vật", symbol: "person.fill", tint: .purple, enabled: true),
        .init(title: "Hiệu Ứng", subtitle: "Giao diện hiệu ứng mô phỏng", symbol: "sparkles", tint: .pink),
        .init(title: "Giao Diện", subtitle: "Bộ giao diện neon", symbol: "paintpalette.fill", tint: .orange, enabled: true),
        .init(title: "Thông Tin", subtitle: "Bảng thông tin nhân vật", symbol: "info.circle.fill", tint: .cyan)
    ]

    var body: some View {
        ScreenContainer {
            ScreenHeader(title: "Mod NV", subtitle: "CHARACTER PANEL")

            SectionCard(title: "MOD NHÂN VẬT", icon: "person.2.fill", accent: .purple) {
                ForEach(items.indices, id: \.self) { index in
                    FeatureRow(item: $items[index])
                }
            }

            CharacterPreview()
            Notice(text: "Các tuỳ chọn là UI demo; không chứa mã sửa đổi hoặc can thiệp game.")

            LaunchButton(title: "MỞ GAME")
                .padding(.bottom, 90)
        }
    }
}

struct ScreenContainer<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                content
            }
            .padding(.horizontal, 30)
            .padding(.top, 45)
        }
    }
}

struct SectionCard<Content: View>: View {
    let title: String
    let icon: String
    let accent: Color
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 9) {
                Capsule()
                    .fill(accent)
                    .frame(width: 5, height: 28)

                Image(systemName: icon)
                    .foregroundStyle(accent)

                Text(title)
                    .font(.system(size: 18, weight: .heavy))
                    .foregroundStyle(accent)

                Spacer()

                Text("AUTO")
                    .font(.system(size: 12, weight: .heavy))
                    .foregroundStyle(accent)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(accent.opacity(0.08)))
                    .overlay(Capsule().stroke(accent.opacity(0.6), lineWidth: 1))
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 18)

            content
        }
        .background(
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(red: 0.10, green: 0.11, blue: 0.17).opacity(0.97))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .stroke(accent.opacity(0.58), lineWidth: 1.5)
        )
        .shadow(color: accent.opacity(0.12), radius: 20)
    }
}

struct FeatureRow: View {
    @Binding var item: FeatureItem

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: item.symbol)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 43, height: 43)
                .background(RoundedRectangle(cornerRadius: 12).fill(item.tint.opacity(0.82)))

            VStack(alignment: .leading, spacing: 3) {
                Text(item.title)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.white)

                Text(item.subtitle)
                    .font(.system(size: 12.5, weight: .medium))
                    .foregroundStyle(.gray)
                    .lineLimit(2)
            }

            Spacer()

            if !item.available {
                Image(systemName: "xmark")
                    .foregroundStyle(.red)
            } else if item.enabled {
                Image(systemName: "checkmark")
                    .foregroundStyle(.green)
            }

            Toggle("", isOn: $item.enabled)
                .labelsHidden()
                .tint(item.tint)
                .disabled(!item.available)
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 14)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.white.opacity(0.055))
                .frame(height: 1)
                .padding(.leading, 22)
        }
    }
}

struct RadarPreview: View {
    var body: some View {
        ZStack {
            Circle().stroke(.cyan.opacity(0.5), lineWidth: 1)
            Circle().stroke(.cyan.opacity(0.25), lineWidth: 1).padding(30)
            Circle().stroke(.cyan.opacity(0.18), lineWidth: 1).padding(60)
            Rectangle().fill(.cyan.opacity(0.16)).frame(height: 1)
            Rectangle().fill(.cyan.opacity(0.16)).frame(width: 1)
            Circle().fill(.cyan).frame(width: 8, height: 8).shadow(color: .cyan, radius: 8)
        }
        .frame(height: 180)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 22).fill(Color.white.opacity(0.025)))
        .overlay(RoundedRectangle(cornerRadius: 22).stroke(.cyan.opacity(0.25)))
        .padding(.top, 18)
    }
}

struct CharacterPreview: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 58))
                .foregroundStyle(.purple, .white)
            VStack(alignment: .leading, spacing: 5) {
                Text("CHARACTER PREVIEW")
                    .font(.system(size: 13, weight: .heavy))
                    .foregroundStyle(.purple)
                Text("Neon character panel")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                Text("Preview only")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 22).fill(Color.white.opacity(0.025)))
        .overlay(RoundedRectangle(cornerRadius: 22).stroke(.purple.opacity(0.28)))
        .padding(.top, 18)
    }
}

struct AssetPackStatus: View {
    private var loaded: Bool {
        Bundle.main.url(forResource: "cache_res", withExtension: "unity3d") != nil
    }

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: loaded ? "checkmark.seal.fill" : "exclamationmark.triangle.fill")
                .foregroundStyle(loaded ? .green : .orange)

            VStack(alignment: .leading, spacing: 2) {
                Text("ASSET PACK")
                    .font(.system(size: 12, weight: .heavy))
                    .foregroundStyle(.white)
                Text(loaded ? "cache_res.unity3d đã được đóng gói trong app" : "Không tìm thấy asset pack")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.gray)
            }

            Spacer()
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.035)))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.cyan.opacity(0.18)))
        .padding(.bottom, 14)
    }
}

struct Notice: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .bold))
            .foregroundStyle(.red.opacity(0.9))
            .multilineTextAlignment(.center)
            .padding(.vertical, 18)
    }
}

struct LaunchButton: View {
    var title = "MỞ GAME"

    private func openFreeFireMax() {
        let candidates = [
            URL(string: "freefiremax://"),
            URL(string: "com.dts.freefiremax://")
        ].compactMap { $0 }

        if let url = candidates.first(where: { UIApplication.shared.canOpenURL($0) }) {
            UIApplication.shared.open(url)
        }
    }

    var body: some View {
        Button(action: openFreeFireMax) {
            HStack(spacing: 10) {
                Image(systemName: "play.fill")
                Text(title)
            }
            .font(.system(size: 20, weight: .heavy))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 68)
            .background(
                LinearGradient(
                    colors: [.purple, .blue, .cyan],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

struct BottomTabs: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: 5) {
            bottomTab(icon: "bolt.fill", title: "Proxy", index: 0)
            bottomTab(icon: "location.fill", title: "Định Vị", index: 1)
            bottomTab(icon: "person.2.fill", title: "Mod NV", index: 2)
        }
        .padding(5)
        .background(.ultraThinMaterial, in: Capsule())
        .overlay(Capsule().stroke(.white.opacity(0.10)))
    }

    private func bottomTab(icon: String, title: String, index: Int) -> some View {
        Button { selectedTab = index } label: {
            HStack(spacing: 6) {
                Image(systemName: icon)
                Text(title)
            }
            .font(.system(size: 13, weight: .bold))
            .foregroundStyle(selectedTab == index ? .cyan : .gray)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 11)
            .background(
                Capsule().fill(selectedTab == index ? Color.cyan.opacity(0.10) : .clear)
            )
        }
        .buttonStyle(.plain)
    }
}

struct NeonBackground: View {
    var body: some View {
        Canvas { context, size in
            let spacing: CGFloat = 54
            var path = Path()

            stride(from: 0, through: size.width, by: spacing).forEach { x in
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
            }

            stride(from: 0, through: size.height, by: spacing).forEach { y in
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
            }

            context.stroke(path, with: .color(.white.opacity(0.035)), lineWidth: 1)
        }
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.025, green: 0.03, blue: 0.09),
                    Color(red: 0.055, green: 0.025, blue: 0.13),
                    Color(red: 0.015, green: 0.04, blue: 0.10)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .ignoresSafeArea()
    }
}
