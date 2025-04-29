//
//  ContentView.swift
//  BipTheGuy
//
//  Created by Student2 on 4/29/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        VStack {
            Image("clown")
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    playsSound(soundName: "punchSound")
                }
            
            Spacer()
            
            Button {
                //TODO: button action here
            } label: {
                Label("Photo Library", systemImage: "photo.fill.on.rectangle.fill")
            }

        }
        .padding()
    }
    
    func playsSound(soundName: String){
        if audioPlayer != nil && audioPlayer.isPlaying {
        audioPlayer.stop()
    }
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) creatingaudioPlayer")
        }
    }
}

#Preview {
    ContentView()
}
