//
//  InstanceEditor.swift
//  OpenVK Swift
//
//  Created by Ry0 on 15.06.2025.
//

import SwiftUI

struct InstanceEditor: View {
    @ObservedObject var presenter: LoginPresenter
    
    var body: some View {
        List {
            Section("Основные инстансы") {
                ForEach(presenter.mainInstances, id: \.self) { instance in
                    HStack {
                        Label(instance,
                              systemImage: "checkmark.seal.fill")
                        .foregroundColor(.green)
                        Spacer()
                    }
                }
            }
            
            Section("Добавленные инстансы") {
                ForEach(presenter.addedInstances, id: \.self) { instance in
                    HStack {
                        Label(instance,
                              systemImage: instance.contains("https") ? "lock.fill" : "globe")
                        Spacer()
                    }
                }
                .onDelete(perform: presenter.deleteInstances)
                Button {
                    presenter.showAddAlert = true
                } label: {
                    Label("Добавить", systemImage: "plus")
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Инстансы")
        .background(
                    TextFieldWrapper(
                        isPresented: $presenter.showAddAlert,
                        alert: TextFieldAlert(
                            title: "Добавить инстанс",
                            message: "Введите адрес инстанса",
                            placeholder: "https://example.com",
                            accept: "Добавить",
                            cancel: "Отмена",
                            action: { text in
                                if let text = text {
                                    presenter.newInstanceText = text
                                    presenter.addInstance()
                                }
                            }
                        )
                    )
                )
        /*.alert("Добавить инстанс", isPresented: $presenter.showAddAlert, actions: {
            TextField("https://example.com", text: $presenter.newInstanceText)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            Button("Добавить", action: presenter.addInstance)
            Button("Отмена", role: .cancel) { }
        }, message: {
            Text("Введите адрес инстанса")
        })*/
    }
}

#Preview {
    InstanceEditor(presenter: LoginPresenter.mock)
}
