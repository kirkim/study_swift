// MARK: - 9. ForEach
//struct LocationInfo: Hashable, Identifiable {
//    var id = UUID()
//    var city = ""
//    var weather = ""
//}
//
//struct ContentView: View {
//    @State private var Locations = [
//        LocationInfo(city: "Seoul", weather: "sunny"),
//        LocationInfo(city: "Busan", weather: "cloudy"),
//        LocationInfo(city: "Seoul", weather: "sunny"),
//        LocationInfo(city: "LA", weather: "rainy")
//    ]
//    var body: some View {
//        List {
//            ForEach(Locations, id: \.self) { location in
//                HStack {
//                    Text("\(location.city)")
//                    Text("\(location.weather)")
//                }
//            }
//
//            ForEach(Locations) { location in
//                HStack {
//                    Text("\(location.city)")
//                    Text("\(location.weather)")
//                }
//            }
//
//            ForEach(0..<Locations.count) { i in
//                HStack {
//                    Text("\( (i + 1))")
//                    Text("\(Locations[i].city)")
//                    Text("\(Locations[i].weather)")
//                }
//            }
//        }
//    }
}

// MARK: - 10. List Section
//struct Animal: Identifiable {
//    let id = UUID()
//    let name: String
//    let index: Int
//}
//
//struct ContentView: View {
//
//    var animalList = [
//        Animal(name: "dog", index: 2),
//        Animal(name: "dog", index: 1),
//        Animal(name: "cat", index: 4),
//        Animal(name: "cat", index: 7),
//        Animal(name: "bird", index: 8),
//        Animal(name: "cat", index: 5),
//        Animal(name: "bird", index: 9),
//        Animal(name: "dog", index: 3),
//        Animal(name: "cat", index: 6)
//    ]
//
//    // dog: [Animal, Animal, Animal]
//    var animalGrouped: [String : [Animal]] {
//
//        var groupData = Dictionary(grouping: animalList) {
//            $0.name }
//        for (key, value) in groupData {
//            groupData[key] = value.sorted(by: { $0.index < $1.index })
//        }
//        return groupData
//    }
//
//    var groupKey: [String] {
//        animalGrouped.map( { $0.key } )
//    }
//
//    var body: some View {
//        List {
//            ForEach(groupKey, id: \.self) { animalKey in
//                Section {
//                    ForEach(animalGrouped[animalKey]!) { animal in
//                        HStack {
//                            Text("\(animal.index)")
//                            Text("\(animal.name)")
//                        }
//                    }
//                } header: {
//                    Text("\(animalKey)")
//                }
//
//            }
//        }
//    }
//}

// MARK: - 11. ViewModifier
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Main Title!")
                .font(.largeTitle)
                .foregroundColor(.black)
                .bold()
            Text("Sub Title!")
                .modifier(TextMyStyle())
            Text("Descripttion!")
                .modifier(TextMyStyle(myColor: .red))
            Text("Descripttion!")
                .customFont(color: .orange)
        }
    }
}

struct TextMyStyle: ViewModifier {
    var myWeight = Font.Weight.regular
    var myFont = Font.title2
    var myColor = Color.black

    func body(content: Content) -> some View {
        content
            .font(myFont.weight(myWeight))
            .foregroundColor(myColor)
            .padding(.bottom, 20)
            .font(myFont.italic()) // italic ?????? ???????????? ??? ??? ????????? ????????? ????????? ??????????????? ??????????????????.
    }
}

extension Text {
    func customFont(color: Color) -> Text {
        self
            .font(.title2)
            .bold()
            .italic()
            .foregroundColor(color)
    }
}

// MARK: - 12. Alert View
//struct ContentView: View {
//
//    @State private var isShowAlert = false
//    @State private var selectText = "x"
//
//    var body: some View {
//        VStack{
//            Spacer()
//            Button("show alert") {
//                isShowAlert.toggle()
//            }
//            .alert(isPresented: $isShowAlert) {
////                Alert(title: Text("alert title"), message: nil, dismissButton: .default(Text("s")))
//                let primaryButton = Alert.Button.default(Text("done")) {
//                    selectText = "done"
//                }
//
//                let secondaryButton = Alert.Button.default(Text("cancel")) {
//                    selectText = "cancel"
//                }
//                return Alert(title: Text("show alert"),
//                             primaryButton: primaryButton,
//                             secondaryButton: secondaryButton)
//            }
//            Spacer()
//            Text("\(isShowAlert.description)")
//            Spacer()
//            Text("\(selectText)")
//            Spacer()
//        }
//    }
//}

// MARK: - 13. WebView Basic
///* ContentView.swift */
//struct ContentView: View {
//    var body: some View {
//
////        WebView(url: "https://kirkim.github.io") // swiftUI?????? ???????????? ??????
//        MyWebVC() // storyboard ???????????? ??????????????????????????? ????????????(??? ????????? ????????? ??????)
//    }
//}
//
//// UIViewController
//struct MyWebVC: UIViewControllerRepresentable {
//
//    func makeUIViewController(context: Context) -> some UIViewController {
//
//        let webVC = UIStoryboard(name: "WebViewController", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//
//        // ????????????????????? ?????? ????????? ???????????? ??? ??????, ???????????? ?????? ????????? ????????? ??????????????????
//        let navi = UINavigationController(rootViewController: webVC)
//
//        return navi
//    }
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//    }
//}
//
///* WebView.swift */
//import WebKit
//import SwiftUI
//
//struct WebView: UIViewRepresentable {
//
//    var url: String
//
//    func makeUIView(context: Context) -> some UIView {
//
//        let url = URL(string: self.url)
//        let request = URLRequest(url: url!)
//
//        let wkWebView = WKWebView()
//        wkWebView.load(request)
//
//        return wkWebView
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//
//    }
//}
//
//
///* WebViewController.swift */
//import UIKit
//import WebKit
//
//class WebViewController: UIViewController, WKNavigationDelegate {
//
//    @IBOutlet weak var webView: WKWebView!
//
//    var url = "https://kirkim.github.io"
//
//    override func viewDidLoad() {
//        self.webView.navigationDelegate = self
//        self.webView.load(URLRequest(url: URL(string: url)!))
//    }
//
//    // data??? ???????????? ??? ????????? didFinish(????????????) ???????????? ???????????? ??????.
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        // get webView Title
//        self.webView.evaluateJavaScript("document.title") { (result, error) in
//            self.navigationItem.title = result as? String
//        }
//    }
//}

 //MARK: - 14. WebView JS Bridge => swiftUI??? ????????? ??????
// //13??? WebView.swift, ContentView.swift??? ?????? => story?????????????????? ??????????????? ??????????????? ???????????????.
//
///* WebViewController */
//import UIKit
//import WebKit
//
//class WebViewController: UIViewController, WKScriptMessageHandler {
//
//    var webView: WKWebView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let contentController = WKUserContentController()
//        contentController.add(self, name: "iPhoneInfo") // ????????? ????????? ??????
//        contentController.add(self, name: "aaa") // ????????? ????????? ??????
//        contentController.add(self, name: "bbb") // ????????? ????????? ??????
//
//        let configuration = WKWebViewConfiguration()
//        configuration.userContentController = contentController
//
//        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
//        webView.navigationDelegate = self
//        webView.uiDelegate = self
//
//        self.view.addSubview(webView)
//
//        let localFile = Bundle.main.path(forResource: "TestWeb", ofType: "html")
//        let url = URL(fileURLWithPath: localFile!)
//
//        let request = URLRequest(url: url)
//
//        webView.load(request)
//    }
//
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//
//        if message.name == "iPhoneInfo" {
//            print(message.body) // web?????? ???????????? ????????????
//            print("call native")
//        }
//    }
//}
//
//extension WebViewController: WKUIDelegate {
//    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
//        let alertController = UIAlertController(title: "js test", message: message, preferredStyle: .alert)
//        let doneAction = UIAlertAction(title: "??????", style: .default) { _ in
//            completionHandler()
//        }
//
//        alertController.addAction(doneAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//}
//
//extension WebViewController: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("showAlert('hi')", completionHandler: nil)
//    }
//}
//
///* TestWeb.html */
//// ??????????????? ????????? ????????? html?????? ???????????? ?????? ?????????????????? ????????? ?????????. ??? ???????????? ????????? loadiPhonInfo()?????? ????????? ????????????.
//// ??? ?????? ????????? ????????? ?????? ??? ???????????? ??????. ?????? ????????????..
//<!DOCTYPE html>
//<html>
//    <head>
//        <title>JS TEXT</title>
//
//        <script type="text/javascript">
//
//            function showAlert(text){
//                alert('Java Script Test \n' + text)
//            }
//
//            function loadiPhoneInfo(){
//                window.webkit.messageHandlers.iPhoneInfo.postMessage('someParam');
//                window.webkit.messageHandlers.aaa.postMessage('someParam');
//                window.webkit.messageHandlers.bbb.postMessage('someParam');
//            }
//        </script>
//    </head>
//    <body>
//        <button style="font-size:50px;width:500px;height:200px" onclick='loadiPhoneInfo();'>iPhone Info</button></br>
//    </body>
//</html>

// MARK: - 15. Grid
//// CollectionView, ?????????
//struct ContentView: View {
//
//    var columns: [GridItem] {
//        [
////            GridItem(.flexible(minimum: 50, maximum: 200)),
////            GridItem(.adaptive(minimum: 30, maximum: 100))
//            GridItem(.fixed(100))
//        ]
//    }
//
//    var body: some View {
//
//        ScrollView(.horizontal) {
//            LazyHGrid(rows: columns) {
//                Text("hi hello ??????").lineLimit(1)
//                Image(systemName: "music.mic")
//                    .myImageModifier()
//                Image(systemName: "music.mic")
//                    .myImageModifier()
//                Image(systemName: "music.mic")
//                    .myImageModifier()
//                Image(systemName: "music.mic")
//                    .myImageModifier()
//                Image(systemName: "music.mic")
//                    .myImageModifier()
//                Image(systemName: "music.mic")
//                    .myImageModifier()
//                Image(systemName: "music.mic")
//                    .myImageModifier()
//                Image(systemName: "music.mic")
//                    .myImageModifier()
//            }
//        }
//    }
//}
//
//extension Image {
//    func myImageModifier() -> some View {
//        self
//            .resizable()
//            .aspectRatio(1.0, contentMode: .fit)
//    }
//}

// MARK: - 16. Placeholder
//// redact
//
//struct ContentView: View {
//
//    @State private var myString = "hello world"
//
//    @State private var showPlaceholder = false
//
//    var body: some View {
//        VStack {
//            VStack {
//                Image(systemName: "person")
//                    .resizable()
//                    .frame(width: 200, height: 200)
//                    .clipShape(Circle()) // ???????????? ?????????
//                    .overlay(Circle().stroke()) // ?????? ???????????? ?????????
//
//                Text(myString)
//                    .foregroundColor(.red)
//                    .padding()
//                Button("click me") {
//                    showPlaceholder.toggle()
//                } // ????????? placeholder??? ????????? ????????? ????????? ?????????
//            }
//            .redacted(reason: showPlaceholder ? .placeholder : .init()) // .init()??? ???????????? ?????? ??????
//
//        }
//    }
//}

// MARK: - 17. NavigationView
//// NavigationView: ????????? ???????????? ????????? ???????????? ?????? ????????? ????????? ????????????.
//
//struct ContentView: View {
//
//    init(){
////        // ?????? ??????????????? ?????? ????
////        UINavigationBar.appearance()
////            .titleTextAttributes = [.foregroundColor
////                                    : UIColor.blue]
//        // ?????? ??? ==> iOS15 ?????? ????????????????????? ????????? ???????????????.
//        let myAppearance = UINavigationBarAppearance()
//
//        myAppearance.titleTextAttributes = [
//            .foregroundColor : UIColor.blue,
//            .font : UIFont.italicSystemFont(ofSize: 30)
//        ]
//
//        // ??? ??????????????? ?????? ???????????? ??????.
//        myAppearance.largeTitleTextAttributes = [
//            .foregroundColor : UIColor.green
//        ]
//
////        myAppearance.configureWithOpaqueBackground()
//        myAppearance.backgroundColor = .systemRed
//
//        UINavigationBar.appearance().standardAppearance = myAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance =  myAppearance
//        UINavigationBar.appearance().compactAppearance = myAppearance
////        UINavigationBar.appearance().scrollEdgeAppearance =  UINavigationBar. ().standardAppearance
//
////        // ?????? ??? ????????? ????????? ?????? ?????? ?????????????????? ???????????? ?????? ????????? ????????????.??????
////        UINavigationBar.appearance().backgroundColor = .orange
//
//        // detail??? ???????????? ??? title ????????????
//        UINavigationBar.appearance().tintColor = .yellow
//    }
//
//    var body: some View {
////         // 1?????? ??????????????? ????????? ??????
////        NavigationView {
////            List{
////                Text("Hello, world!")
////                    .padding()
////            }.navigationBarTitle("Hello", displayMode: .large)
////        }
//
////        // 2?????? ??????????????? ?????? ??????
////        NavigationView {
////            NavigationLink("click me", destination: Text("detail"))
////            .navigationBarTitle("Hello", displayMode: .inline)
////        }
//
//        // 3?????? ??????????????? ?????? ??????
//        NavigationView {
//            List{
//                NavigationLink {
//                    Text("Destination")
//                } label: {
//                    HStack{
//                        Image(systemName: "person")
//                        Text("Navigate")
//                    }
//                }
//            }
//            .navigationBarTitle("Hello", displayMode: .large)
//        }
//    }
//}

// MARK: - 18. TabView
//struct ContentView: View {
//
//    var body: some View {
//        TabView {
//            First()
//                .tabItem {
//                    Image(systemName: "person")
//                    Text("person")
//                }
//                .edgesIgnoringSafeArea(.top) // ????????? ????????? ????????? ?????? ??????
//            Second()
//                .tabItem {
//                    Image(systemName: "person.fill")
//                    Text("person.fill")
//                }
//        }
//    }
//}
//
//struct First: View {
//    var body: some View {
//        ZStack {
//            Color.orange
//            Text("first")
//        }
//    }
//}
//
//struct Second: View {
//    var body: some View {
//        ZStack {
//            Color.green
//            Text("second")
//        }
//    }
//}

// MARK: - 19, 20 Toggle
//// swiftUI?????? ??????????????? ?????? toggle??? ???????????? ??? ???????????????. ????????? ?????? ???????????? ???????????? ????????? ??????.
//// GeometryReader ???????????? ????????????
//struct CustomToggle: ToggleStyle {
//    func makeBody(configuration: Configuration) -> some View {
//
//        // Design
//
//        RoundedRectangle(cornerRadius: 100)
//            .foregroundColor(configuration.isOn ? .red : .blue)
//            .overlay(
//                GeometryReader(content: { geometry in
//                    ZStack {
//                        Circle().foregroundColor(.orange)
//                            .frame(width: geometry.size.height)// ???????????? ????????? ????????????
//                        Text(configuration.isOn ? "On" : "Off")
//                            .foregroundColor(configuration.isOn ? .red : .blue)
//                    }
//                    .offset(x: configuration.isOn ? geometry.frame(in: .local).minX : geometry.frame(in: .local).maxX - geometry.size.height)
//                    .animation(.easeInOut(duration: 0.4))
//                    .shadow(radius: 10)
//                })
//            )
//            .clipShape(Capsule()) // clipShape??? ????????? ??? => ????????? ??????, Capsule()??? ?????????????????? ??????
//            .onTapGesture(count: 1) {
//                configuration.isOn.toggle()
//            }
//    }
//}
//
//struct ContentView: View {
//
//    @State private var isOn = false
//
//    var body: some View {
//        Toggle("\(isOn.description)", isOn: $isOn)
//            .toggleStyle(CustomToggle())
//            .frame(width: 200, height: 50)
//    }
//}

// MARK: - 21

