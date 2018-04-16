# CleanAndSimpleArchitecture

Requirements:

- Xcode 9.3

A simple CRUD app that aims to create a clean and simple architecture with as little dependencies as possible.
The demo app consumes a [simple mock API](https://app.swaggerhub.com/apis/particle-iot/box/0.1).
The goal of this app wasn't to create a super functional application that... does something 😅 Please note that the API always returns the same values: its responses are statically mocked.

The goal was to demonstrate a solution for:

- iOS App Architecture
- Observing
- App routing
- Easy app logic testing
- Dividing app into separate modules
- Simple API definition with Alamofire
- Simple error handling
- Dependency Injection

Code has been divided in separate targets which makes the app modular and cleanly draws a line between different domains of the app and their tests.

# Architecture

The architecture of my invention is a simple evolution of MVVM. Its goal was to separate business logic and presentation logic.
It's similar to [VIPER](https://www.objc.io/issues/13-architecture/viper/) but simpler to set up.

<br>
<br>
<br>
<p align="center"> 
<img src="https://i.imgur.com/sXdISJe.png" width="700">
</p>

