//
//  LoginView.swift
//  ovk
//
//  Created by Ry0 on 09.06.2025.
//

import SwiftUI

struct LoginView: View {
    @Binding var debug: Bool
    @Binding var isMainViewUpdated: Bool
    
    @StateObject var presenter = LoginPresenter(instance: "https://ovk.to")
    
    var body: some View {
        NavigationView {
            Form {
                // Debug section
                if debug {
                    Section(header: Text("Debug")) {
                        TextField("Token", text: $presenter.debugToken)
                        Button("Войти") {
                            presenter.handleCustomTokenLogin()
                        }
                    }
                }
                
                // Instance section
                Section(header: Text("Инстанс")) {
                    Menu {
                        // Основные инстансы
                        Section("Основные инстансы") {
                            ForEach(presenter.mainInstances, id: \.self) { instance in
                                Button(action: {
                                    presenter.instance = instance
                                }) {
                                    Label(instance,
                                          systemImage: "checkmark.seal")
                                    .foregroundColor(.green)
                                }
                            }
                        }
                        
                        // Добавленные инстансы с возможностью удаления
                        Section("Добавленные инстансы") {
                            ForEach(presenter.addedInstances, id: \.self) { instance in
                                Button(action: {
                                    presenter.instance = instance
                                }) {
                                    Label(instance,
                                          systemImage: instance.contains("https") ? "lock.fill" : "globe")
                                }
                            }
                        }
                        
                        Button {
                            presenter.showEditSheet = true
                        } label: {
                            Label("Редактировать список", systemImage: "pencil")
                        }
                    } label: {
                        Text("\(presenter.instance)")
                    }
                    .sheet(isPresented: $presenter.showEditSheet, content: {
                        InstanceEditor(presenter: presenter)
                    })
                }
                
                // Login section
                Section(header: Text("Данные для входа"), footer: !presenter.error.isEmpty ? Text(presenter.error).foregroundColor(Color.red) : nil) {
                    TextField("Логин", text: $presenter.login)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onChange(of: presenter.login, perform: { value in
                            presenter.error = ""
                        })
                    SecureField("Пароль", text: $presenter.password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onChange(of: presenter.password, perform: { value in
                            presenter.error = ""
                        })
                }
                
                
                // Actions section
                Section {
                    Button(action: {
                        presenter.handleLogin()
                    }) {
                        HStack {
                            Text("Войти")
                            if presenter.isLoading {
                                ProgressView()
                            }
                        }
                    }
                    .background(
                                TextFieldWrapper(
                                    isPresented: $presenter.show2FA,
                                    alert: TextFieldAlert(
                                        title: "Требуется 2FA код",
                                        message: "Введите код двухфакторной аутентификации", placeholder: "Код",
                                        accept: "Войти",
                                        cancel: "Отмена",
                                        action: { text in
                                            if let text = text {
                                                presenter.code = text
                                                presenter.handleLogin()
                                            }
                                        }
                                    )
                                )
                            )
                    /*.alert("Требуется 2FA код", isPresented: $presenter.show2FA, actions: {
                        TextField("Код", text: $presenter.code)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        Button("Войти", action: presenter.handleLogin)
                        Button("Отмена", role: .cancel) { }
                    }, message: {
                        Text("Введите код двухфакторной аутентификации")
                    })*/
                    Button("Зарегистрироваться в браузере") {
                        presenter.openUrl(path: "reg")
                    }
                    Button("Сбросить пароль") {
                        presenter.openUrl(path: "restore")
                    }
                    .sheet(isPresented: $presenter.isWebViewOpened, content: {
                        NavigationView {
                            WebView(url: presenter.webViewURL!)
                                .navigationTitle("OpenVK")
                                .navigationBarTitleDisplayMode(.inline)
                        }.navigationViewStyle(.stack)
                    })
                }
            }
            .alert(isPresented: $presenter.showAlert, content: {
                AlertManager.shared.showAlert(message: presenter.alertText)
            })
            .navigationBarTitle("OpenVK Swift")
            .toolbar {
                NavigationLink(destination: LoginSettings(debug: $debug, isMainViewUpdated: $isMainViewUpdated)) {
                    Image(systemName: "gearshape")
                }
            }.onChange(of: presenter.shouldNavigateToMainView) { newValue in
                if newValue {
                    isMainViewUpdated.toggle()
                }
            }
        }.navigationViewStyle(.stack)
    }
}

#Preview {
    MainView()
}
