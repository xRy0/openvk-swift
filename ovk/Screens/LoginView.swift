//
//  ContentView.swift
//  ovk
//
//  Created by Isami Riša on 23.10.2023.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var debug: Bool
    
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var twoFA: String = ""
    
    @State private var showAlert: Bool = false
    @State private var alertText: String = ""
    
    @State private var isLoading: Bool = false
    
    @State private var instance = "https://ovk.to"
    
    @State private var isWebViewOpened: Bool = false
    @State private var webViewURL: URL =  URL(string: "https://ovk.to/reg")!
    
    @State private var showError: Bool = false
    @State private var errorText: String = ""
    
    @State private var show2FA: Bool = false
    
    
    @State private var customToken = ""
    
    // Эта хрень обновляет view 👇🏼
    @State private var isViewUpdated = false
    @Binding var isMainViewUpdated: Bool
    
    
    var body: some View {
        NavigationView {
            Form {
                
                if debug {
                    Section /* DEBUG */ {
                        Text("Зайти через токен (обратите внимание, что будет использован инстанс указанный ниже, так же обратите внимание что нет проверки на верность токена):")
                        TextField("Token", text: $customToken)
                        Button("Войти") {
                            if !saveValueToKeychain(forKey: "token", value: customToken) {
                                errorText = "Токен не может быть сохранён, так как имеется другой"
                                showError = true
                            }
                            else {
                                isMainViewUpdated.toggle()
                                saveValueToUserDefaults(forKey: "instance", value: instance)
                            }
                        }
                    } header: {
                        Text("Debug")
                    }
                }
                
                
                Section /* Поле ввода инстанса */ {
                    TextField("Адрес", text: $instance)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onChange(of: login, perform: { value in
                            showError = false
                            show2FA = false
                        })
                } header: {
                    Text("Инстанс")
                }
                
                
                Section /* Поля ввода данных для входа */ {
                    TextField("Логин", text: $login)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onChange(of: login, perform: { value in
                            showError = false
                            show2FA = false
                        })
                    SecureField("Пароль", text: $password)
                        .onChange(of: password, perform: { value in
                            showError = false
                            show2FA = false
                        })
                    if show2FA {
                        TextField("2FA", text: $twoFA)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .onChange(of: login, perform: { value in
                                showError = false
                            })
                    }
                } header: {
                    Text("Данные для входа")
                } footer: {
                    if showError {
                        Text(errorText)
                            .foregroundColor(Color.red)
                    }
                }
                
                
                Section /* Кнопки войти, зарегистрироваться */ {
                    Button (action:{
                        isLoading = true
                        
                        // 👇🏼 Эта функция вызывается после того как отрабатывает LogIn
                        func completion(response: [String : Any]?) {
                            isLoading = false
                            
                            if (response!["error_msg"] != nil) {
                                if response!["error_msg"] as! String == "Invalid 2FA code" && !show2FA {
                                    show2FA = true
                                    isViewUpdated.toggle()
                                }
                                else {
                                    errorText = response!["error_msg"] as! String
                                    showError = true
                                }
                            }
                            else {
                                if !saveValueToKeychain(forKey: "token", value: response!["access_token"]! as! String) {
                                    errorText = "Токен не может быть сохранён, так как имеется другой"
                                    showError = true
                                }
                                else {
                                    isMainViewUpdated.toggle()
                                    saveValueToUserDefaults(forKey: "instance", value: instance)
                                }
                            }
                            
                        }
                        LogIn(login: login, password: password, instance: instance, code: twoFA, completion: completion)
                    }) {
                        HStack(){
                            Text("Войти")
                                .frame(maxWidth: .infinity, alignment: .leading)
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
                Alert(title: Text(alertText))
            })
                // Костыль, чтобы обновлять экран ¯\_(ツ)_/¯ 👇🏼 (не осуждайте пж)
                .background(isViewUpdated ? Color.clear : Color.clear)
                .allowsHitTesting(!isLoading)
                .navigationBarTitle("OpenVK Swift")
                .toolbar {
                    NavigationLink (destination: LoginSettings(debug: $debug, isMainViewUpdated: $isMainViewUpdated)) {Image(systemName: "gearshape")}
                }
        }.navigationViewStyle(.stack)
    }
}

#Preview {
    MainView()
}
