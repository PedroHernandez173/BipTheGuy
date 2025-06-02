//
//  ContentView.swift
//  BipTheGuy
//
//  Created by Student2 on 4/29/25.
//

import SwiftUI
import AVFAudio
import PhotosUI

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var isFullSize = true
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var bipImage = Image("clown")
    
    var body: some View {
        VStack {
            Spacer()
            
            bipImage
                .resizable()
                .scaledToFit()
                .scaleEffect(isFullSize ? 1.0 : 0.9)
                .onTapGesture {
                    playsSound(soundName: "punchSound")
                    isFullSize = false
                    withAnimation (.spring(response: 0.3, dampingFraction: 0.3)){
                        isFullSize = true
                    }
                }
            
            Spacer()
            
            PhotosPicker(selection:  $selectedPhoto, matching:  .images, preferredItemEncoding: .automatic ) {
                Label("Photo Library", systemImage: "photo.fill.on.rectangle.fill")
            }
            .onChange(of:  selectedPhoto) {
                Task {
                    guard let selectedImage = try? await
                            selectedPhoto?.loadTransferable(type: Image.self) else {
                        print("😡 ERROR: Could not get Image from loadTranferrable")
                        return
                    }
                    bipImage = selectedImage
                }
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
