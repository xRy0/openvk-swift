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
    
    @State private var instance: String = "https://ovk.to"
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var twoFA: String = ""
    @State private var showAlert: Bool = false
    @State private var showError: Bool = false
    @State private var alertText: String = ""
    @State private var isLoading: Bool = false
    @State private var customToken = ""
    @State private var show2FA = false
    @State private var webViewURL: URL =  URL(string: "https://ovk.to/reg")!
    @State private var isWebViewOpened = false
    
    
    var body: some View {
        NavigationView {
            Form {
                // Debug section
                if debug {
                    Section(header: Text("Debug")) {
                        TextField("Token", text: $customToken)
                        Button("Войти") {
                            if !saveValueToKeychain(forKey: "token", value: customToken) {
                                alertText = "Токен не может быть сохранён, так как имеется другой"
                                showAlert = true
                                showError = true
                            } else {
                                isMainViewUpdated.toggle()
                                saveValueToUserDefaults(forKey: "instance", value: instance)
                            }
                        }
                    }
                }
                
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
                        isLoading = true
                        LoginService.shared.login(instance: instance, username: login, password: password) { response in
                            isLoading = false
                            
                            if let errorMsg = response?["error_msg"] as? String {
                                if errorMsg == "Invalid 2FA code" && !show2FA {
                                    show2FA = true
                                } else {
                                    alertText = errorMsg
                                    showAlert = true
                                    showError = true
                                }
                            } else if let token = response?["access_token"] as? String {
                                if !saveValueToKeychain(forKey: "token", value: token) {
                                    alertText = "Токен не может быть сохранён, так как имеется другой"
                                    showAlert = true
                                    showError = true
                                } else {
                                    isMainViewUpdated.toggle()
                                    saveValueToUserDefaults(forKey: "instance", value: instance)
                                }
                            }
                        }
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
                }
            }
        }.navigationViewStyle(.stack)
    }
}

#Preview {
    MainView()
}
