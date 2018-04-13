# CleanAndSimpleArchitecture

A simple CRUD app that aims to create a clean and simple architecture with as little dependencies as possible.
The demo app consumes a [simple mock API](https://app.swaggerhub.com/apis/particle-iot/box/0.1).
The goal of this app wasn't to create a super functional application that... does something 😅

The goal was to demonstrate a solution for:

- iOS App Architecture
- Observing
- App routing
- Easy app logic testing
- Dividing app into separate modules

# Architecture

The architecture of my invention is a simple evolution of MVVM. Its goal was to separate business logic and presentation logic.
It's similar to [VIPER](https://www.objc.io/issues/13-architecture/viper/) but simpler to set up.

![arch](https://pbs.twimg.com/media/DCwJoM-XUAAJJD2?format=jpg)
