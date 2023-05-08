//
//  ModuleView.swift
//  DreyfusQuestionnaire
//
//  Created by Matviy Suk on 05.03.2023.
//

import SwiftUI
import Charts

struct ModuleView: View {
    @ObservedObject private(set) var viewModel: ModuleViewModel
    
    @State private var showAnalytics = false
    @State private var currentIndex: Int = .zero
        
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(viewModel.module.questions.indices, id: \.self) { index in
                VStack(spacing: 100) {
                    questionView(viewModel.module.questions[index].title)
                    
                    VStack {
                        ForEach(Mark.allCases, id: \.self) { mark in
                            buttonView(index: index, mark: mark)
                        }
                    }
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .navigationTitle(viewModel.module.type.title)
        .sheet(isPresented: $showAnalytics) { analyticsView }
        .toolbar { toolbarItems }
    }
    
    private var analyticsView: some View {
        GeometryReader { geo in
            Chart(viewModel.module.questions.indices, id: \.self) { index in
                BarMark(
                    x: .value("Type", "№ \(index + 1)"),
                    y: .value("Mark", viewModel.module.questions[index].mark?.rawValue ?? .zero)
                )
            }
            .padding([.top, .leading])
            .frame(height: geo.size.height)
        }
        .presentationDragIndicator(.visible)
        .presentationDetents([.medium])
    }
    
    private var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.restartModule()
                    currentIndex = .zero
                }) {
                    Image(systemName: "restart.circle")
                }
                Button(action: {
                    showAnalytics.toggle()
                }) {
                    Image(systemName: "chart.bar")
                }
            }
        }
    }
    
    private func questionView(_ title: String) -> some View {
        Text(title)
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private func buttonView(index: Int, mark: Mark) -> some View {
        Button(action: {
            viewModel.module.questions[index].mark = mark
            
            if currentIndex < viewModel.module.questions.count - 1 {
                currentIndex += 1
            } else {
                showAnalytics = true
            }
        }) {
            Text(viewModel.module.questions[index].getAnswerFor(mark))
                .font(.title2)
        }
        .buttonStyle(.bordered)
        .foregroundColor(.accentColor)
        .tint(viewModel.module.questions[index].mark == mark ? .accentColor : .gray)
    }
    
}

struct ModuleView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleView(viewModel: .init(container: .preview, module: .mock))
    }
}
