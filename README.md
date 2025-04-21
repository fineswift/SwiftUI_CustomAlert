# Custom Alert for SwiftUI

![Image](https://github.com/user-attachments/assets/c970dcd2-adaa-440f-a26e-1dcf2c428b59)

전역적으로 큐 방식으로 관리되고, 커스텀 View를 삽입할 수 있는 SwiftUI용 **Custom Alert 컴포넌트**입니다.

`.alertController()` Modifier 하나로 손쉽게 사용 가능하며, `BaseView` 프로토콜을 채택하면 Modifier 없이도 자동으로 Alert가 적용됩니다.

---

## ✨ Features

- ✅ **타이틀 / 콘텐츠 / 버튼** 영역으로 구조화된 커스텀 Alert
- ✅ Alert 본문에 **SwiftUI View**를 삽입하여 사용
- ✅ 전역 **Queue** 기반 Alert 순차 처리
- ✅ 버튼 타입: `confirm / cancel / custom` 지원, 필요시 타입을 추가하여 커스터마이징 가능
- ✅ 버튼 스타일 커스터마이징 가능 (색상, 테두리, 상태별 스타일링)
- ✅ `.alertController()` Modifier로 간편 적용
- ✅ `BaseView` 프로토콜 채택 시 Modifier 없이 자동 적용

---

## 💡 Example

### 1️⃣ Modifier를 사용한 기본 Alert 호출

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Button("Show Alert") {
                Alert.show(
                    title: "알림",
                    isTapDismiss: true,
                    buttons: [.cancel, .confirm]
                ) {
                    Text("커스텀 콘텐츠를 여기에 삽입할 수 있어요!")
                        .padding()
                } completion: { buttonType in
                    print("선택한 버튼: \(buttonType)")
                }
            }
        }
        .alertController() // Alert 표시를 위한 Modifier
    }
}
```

### 2️⃣ `BaseView` 프로토콜 채택으로 더 간결하게

```swift
struct MainView: BaseView {
    var content: some View {
        VStack {
            Button("Alert 호출") {
                Alert.show(
                    title: "경고",
                    isTapDismiss: false,
                    buttons: [.confirm]
                ) {
                    Text("여기에 원하는 커스텀 뷰 삽입!")
                        .padding()
                }
            }
        }
    }
}
```

✅ `BaseView` 사용 시 `alertController()`를 따로 추가할 필요가 없습니다.

---

## ⚠️ 사용 시 주의사항
- `alertController()` Modifier는 **ZStack 또는 View 계층의 가장 바깥쪽에 적용해야** Alert이 전체 화면을 정상적으로 덮습니다.
- `BaseView`를 채택하면 `alertController()`를 명시적으로 호출하지 않아도 자동 적용됩니다.
- `BaseView`를 사용할 경우 `var content: some View` 를 구현해야 화면이 정상적으로 그려집니다.
- Alert은 호출한 순서대로 큐에서 하나씩 순차적으로 화면에 표시됩니다.
