//
//  ContentView.swift
//  ovk
//
//  Created by Isami Riša on 23.10.2023.
//

import SwiftUI

struct LoginView: View {
    @Binding var debug: Bool
    @Binding var isMainViewUpdated: Bool
    
    @StateObject var LoginObj = LoginPresenter(instance: "https://ovk.to")
    
    var body: some View {
        NavigationView {
            Form {
                // Debug section
                if debug {
                    Section(header: Text("Debug")) {
                        TextField("Token", text: $LoginObj.debugToken)
                        Button("Войти") {
                            LoginObj.handleCustomTokenLogin()
                        }
                    }
                }
   /*
                // Instance section
                Section(header: Text("Инстанс")) {
                    TextField("Адрес", text: $instance)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onChange(of: instance, perform: { value in
                            showError = false
                            show2FA = false
                        })
                }
                
                // Login section
                Section(header: Text("Данные для входа"), footer: showError ? Text(alertText).foregroundColor(Color.red) : nil) {
                    TextField("Логин", text: $login)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onChange(of: login, perform: { value in
                            showError = false
                            show2FA = false
                        })
                    SecureField("Пароль", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onChange(of: password, perform: { value in
                            showError = false
                            show2FA = false
                        })
                    if show2FA {
                        TextField("2FA", text: $twoFA)
                    }
                }
                
                // Actions section
                Section {
                    Button(action: {
                        handleLogin(instance: instance, login: login, password: password)
                    }) {
                        HStack {
                            Text("Войти")
                            if isLoading {
                                ProgressView()
                            }
                        }
                    }
                    
                    Button("Зарегистрироваться в браузере") {
                                            webViewURL = URL(string: "\(instance)/reg")!
                                            isWebViewOpened = true
                                        }
                                        Button("Сбросить пароль") {
                                            webViewURL = URL(string: "\(instance)/restore")!
                                            isWebViewOpened = true
                                        }
                                        .sheet(isPresented: $isWebViewOpened, content: {
                                            NavigationView {
                                                WebView(url: webViewURL)
                                                    .navigationTitle("OpenVK")
                                                    .navigationBarTitleDisplayMode(.inline)
                                            }.navigationViewStyle(.stack)
                                        })
                }
            }
            .alert(isPresented: $showAlert, content: {
                AlertManager.shared.showAlert(message: alertText)
            })
            .navigationBarTitle("OpenVK Swift")
            .toolbar {
                NavigationLink(destination: LoginSettings(debug: $debug, isMainViewUpdated: $isMainViewUpdated)) {
                    Image(systemName: "gearshape")
                }*/
            }
        }.navigationViewStyle(.stack)
    }
    
}

#Preview {
    MainView()
}
