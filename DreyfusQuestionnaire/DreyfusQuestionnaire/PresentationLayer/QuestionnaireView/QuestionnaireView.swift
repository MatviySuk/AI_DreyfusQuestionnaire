//
//  QuestionnaireView.swift
//  DreyfusQuestionnaire
//
//  Created by Matviy Suk on 05.03.2023.
//

import SwiftUI
import Charts

struct QuestionnaireView: View {
    @ObservedObject private(set) var viewModel: QuestionnaireViewModel

    @State private var showAnalytics = false
    
    var body: some View {
        List(QuestionnaireModule.allCases, id: \.self) { moduleType in
            NavigationLink(destination: {
                ModuleView(viewModel: .init(
                    container: viewModel.container,
                    module: viewModel.moduleFor(moduleType)
                ))
            }) {
                Text(moduleType.title)
            }
        }
        .listStyle(.inset)
        .navigationTitle("Модель Дрейфусів")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showAnalytics) { analyticsView }
        .toolbar { toolbarItems }
    }
    
    private var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        viewModel.restartQuestionnaire()
                    }
                }) {
                    Image(systemName: "restart.circle")
                }
                Button(action: {
                    withAnimation {
                        showAnalytics.toggle()
                    }
                }) {
                    Image(systemName: "chart.bar")
                }
            }
        }
    }
    
    private var analyticsView: some View {
        GeometryReader { geo in
            Chart(QuestionnaireModule.allCases, id: \.self) { type in
                BarMark(
                    x: .value(
                        viewModel.moduleFor(type).type.title,
                        viewModel.moduleFor(type).type.title
                    ),
                    y: .value("Mark", viewModel.moduleFor(type).getTotalMark())
                )
            }
            .padding([.top, .leading])
            .frame(height: geo.size.height)
        }
        .presentationDragIndicator(.visible)
        .presentationDetents([.medium])
    }
}

struct QuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(viewModel: .init(container: .preview))
    }
}
