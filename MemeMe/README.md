# WeCan_MemeMe_JanghoHan

# MemeMe

## 목차
 - 기본 기능 수정
 - KICK
 - 이슈
 - 스크린샷
 - 영상

---
### 기본기능 수정사항
 - 사진

  1) 사진 캡처 범위 변경

 - 텍스트필드

  1) top textfield 클릭시 화면 이동 안되도록 수정

### KICK
 - TextField 위치 변경

  1) 사용자가 드래그 하여 위치 변경

  2) 위치 초기화버튼을 통해 textfield 위치 초기화

### 이슈
 - textField의 움직임이 사용자의 터치(혹은 마우스)의 이동을 따라가지 못함

 아래의 코드로 작성했었으나

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch: UITouch! = touches.first! as UITouch
            location = touch.location(in: self.view)

            if buttomTextField.frame.contains(location){
                buttomTextField.center = location
            }else if topTextField.frame.contains(location){
                topTextField.center = location
            }
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch: UITouch! = touches.first! as UITouch
            location = touch.location(in: self.view)
            if buttomTextField.frame.contains(location){
                buttomTextField.center = location
            }else if topTextField.frame.contains(location){
                topTextField.center = location
            }
        }


 앞서 언급한 문제점이 발생했다.

 그래서 `UIPanGestureRecognizer`를 전달인자로 받는 메서드를 작성하고, 

 `textField.addGestureRecognizer(gesture)`

 `textField.isUserInteractionEnabled = true`로 설정하여 문제를 해결하였다.

- textField가 두 개가 있고, 각각 textField는 독립적으로 움직여야 한다.

 `UIPanGestureRecognizer`를 전달인자로 받는 메서드를 topTextField, bottomTextField용 두개를 만들어 각각 적용

- topTextField는 키보드를 불러올 시 화면 밖으로 삐져나가버린다.

 `textField.isEditing`으로 해당 textField가 편집중인지 확인한 후

 `textField.frame.maxY > keyboardHeight`인지 체크하고

 `true`이면 화면 이동, `false`이면 이동X

### 스크린샷
![이미지1](https://github.com/BoostCamp/WeCan_MemeMe_JanghoHan/blob/master/images/picture1.png)
![이미지2](https://github.com/BoostCamp/WeCan_MemeMe_JanghoHan/blob/master/images/picture2.png)
![이미지3](https://github.com/BoostCamp/WeCan_MemeMe_JanghoHan/blob/master/images/picture3.png)
![이미지4](https://github.com/BoostCamp/WeCan_MemeMe_JanghoHan/blob/master/images/picture4.png)
![이미지5](https://github.com/BoostCamp/WeCan_MemeMe_JanghoHan/blob/master/images/picture5.png)
![이미지6](https://github.com/BoostCamp/WeCan_MemeMe_JanghoHan/blob/master/images/picture6.png)
![이미지7](https://github.com/BoostCamp/WeCan_MemeMe_JanghoHan/blob/master/images/picture7.png)
![이미지8](https://github.com/BoostCamp/WeCan_MemeMe_JanghoHan/blob/master/images/picture8.png)
![이미지9](https://github.com/BoostCamp/WeCan_MemeMe_JanghoHan/blob/master/images/picture9.png)
![이미지10](https://github.com/BoostCamp/WeCan_MemeMe_JanghoHan/blob/master/images/picture10.png)

### 영상
[![video](http://img.youtube.com/vi/Ps1BOg9D8v0/0.jpg)](https://www.youtube.com/watch?v=Ps1BOg9D8v0&feature=youtu.be)
