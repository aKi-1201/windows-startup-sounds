//
//  ContentView.swift
//  windows startup sound
//
//  Created by 114-1iosClassStudent05 on 2025/10/18.
//

import SwiftUI
import AVFoundation
import Foundation

struct Version: Identifiable {
    let id = UUID()
    let title: String
    let urlString: String
}

// Subtle press animation for buttons
struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

struct ButtonView: View {
    let title: String
    let urlString: String
    let player = AVPlayer()
    
    var body: some View {
        Button {
            if let url = URL(string: urlString) {
                let item = AVPlayerItem(url: url)
                player.replaceCurrentItem(with: item)
                player.play()
            }
        } label: {
            VStack(spacing: 8) {
                Image(title)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity, minHeight: 140)
            .padding(12)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(.white.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
            .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(PressableButtonStyle())
    }
}

struct ContentView: View {
    let versions = [
        Version(title: "Windows 3.1", urlString: "https://www.winhistory.de/more/winstart/mp3/win31.mp3"),
        Version(title: "Windows 95", urlString: "https://www.winhistory.de/more/winstart/mp3/win95.mp3"),
        Version(title: "Windows 98", urlString: "https://www.winhistory.de/more/winstart/mp3/win98.mp3"),
        Version(title: "Windows ME", urlString: "https://www.winhistory.de/more/winstart/mp3/win2000.mp3"),
        Version(title: "Windows XP", urlString: "https://www.winhistory.de/more/winstart/mp3/winxp.mp3"),
        Version(title: "Windows Vista", urlString: "https://www.winhistory.de/more/winstart/mp3/vista.mp3"),
        Version(title: "Windows 7", urlString: "https://www.winhistory.de/more/winstart/mp3/vista.mp3"),
        Version(title: "Windows 8", urlString: "https://www.winhistory.de/more/winstart/mp3/vista.mp3"),
        Version(title: "Windows 10", urlString: "https://www.winhistory.de/more/winstart/mp3/vista.mp3"),
        Version(title: "Windows 11", urlString: "https://www.winhistory.de/more/winstart/mp3/win11.mp3")
    ]
    
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(versions) { ver in
                        ButtonView(title: ver.title, urlString: ver.urlString)
                    }
                }
                .padding(16)
            }
            .navigationTitle("Startup Sounds")
            .background(
                LinearGradient(colors: [Color.blue.opacity(0.12), Color.indigo.opacity(0.12)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    ContentView()
}
