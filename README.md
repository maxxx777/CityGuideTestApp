CityGuideTestApp
====================

This test app presents a result of a test assignment.

Spec
====================

>**Task -  City Guide**
>
>Purpose of the app is to store certain locations within city and render it on the map as well as showing it in the list view.
>
>1) App should provide alphabetical list of cities with nested places for each city on the same table view. It is like on screen mockup:

![ScreenShot](https://cloud.githubusercontent.com/assets/2142832/11014278/859f052e-8559-11e5-8a38-f2b790244645.png)

>2) App should prefill data from json file on initial launch and import it into CoreData  storage.
>3) App should allow to filter locations within specific radius from current device position (1 mile, 10 miles, 100 miles).
>
>There should be ability to add place by "dropping" map pin (same way as native Maps app) and edit location info afterwards.
>
>Requirements:
>- supported iOS version: 7+
>- iPhone app
>- Level-UP: universal app - iPhone/iPad

Functionality
====================

- provides alphabetical list of cities with nested places for each city on the same table view.
- prefills data from json file on initial launch and import it into CoreData  storage.
- allows to filter locations within specific radius from current device position (1 mile, 10 miles, 100 miles).
- adds place by "dropping" map pin, inputting place name and description, attaching photo.
- shows place detail info with ability to show full screen photo.

System Requirements
====================

- iOS 7+
- Universal app - iPhone/iPad
- was created in Xcode 7.0.1

Notes
====================

- As this is only a test task, I chose complex app design specially to demonstrate my understanding of SOLID principles and design patterns. Definitely it should be used easier design for a similar app.
- Also I did not use 3rd party libraries (for example, SDWebImage for async image loading). I did all work by myself (there is also my own code from [my GitHub repository](https://github.com/maxxx777)).
- There is no mockup for detail screen in Spec, so I did UI of detail screen on my own choice.
- It's not clear from Spec how to perform user story of new place addition:
    > There should be ability to add place by "dropping" map pin (same way as native Maps app) and edit location info afterwards.

    So I did it this way:
  - User goes from list screen into detail screen;
  - User fills detail parameters (geolocation by dropping map, enter name and description, attach photo);
  - User saves detail parameters and goes back into list screen.
- Also it is not clear from Spec: can user either add new places only, or also edit/remove default and saved places? I implemented only the first feature, but there is no problem to add the second.
- All user-added places connect to `Unknown City` city. If necessary, city selection can be done, for example, either by selection from city list or place geolocation detecting.
- If this app is for production, I would take some time to profile it with Instruments and cover code and UI with tests.
- This app supports iOS 7 and higher, but it was tested only on iOS 8.4 and iOS 9+ devices. Obviously it should be tested on iOS 7 devices also.

Overview
====================

Designing this app there was chosen [VIPER architecture](https://www.objc.io/issues/13-architecture/viper/).

Horizontal architecture of the app consists of modules. Each screen of the app is a distinct module. It gives flexibility of modules' connection and ability to replace modules.

`AppModuleConnector` class configures dependencies in `didFinishLaunchingWithOptions` method of `AppDelegate`. Then `AppModuleConnector` performs first navigation. Module stack is being created when navigating. Initialization, configuration and navigation of a stack happen inside of a child of `MTRootWireframe` class.

Vertical architecture of a stack is presented on the picture:

![ScreenShot](https://cloud.githubusercontent.com/assets/2142832/9882759/23f43bf8-5bf8-11e5-9723-58b91838c2ad.png)

**View** drawing can be done either programmatically or in storyboards/XIBs.<br />
**ViewController** does only common UIKit things, so it can be reused for several modules.<br />
**Presenter** does all module-specific things (strings, flags, event handling).<br />
In this demo app I used `UITableViewController` (and `UICollectionViewController`) inside `UIViewController` with distinct presenters for both of them, so I separated `UITableView` (and `UICollectionView`) logic from `UINavigationBar` and `UIToolBar` logic.<br />
**Presenter** connected with one or several **Interactors**. **Interactor** is a unit of business-logic. For example, Data Request, Data Fetch, Email/Password Sign In, Facebook Sign In, Location Detect are units of business-logic.<br />
**Interactors** connected with **presenters** asynchronously and with **DataManager** via blocks.<br />
**DataManager** does operations with data, for example select data source (server/local database), merge and cache data.

Usage
====================
Clone the pepository with all submodules (see submodules in `Utilities/External`).

Feedback
====================
My email is 777.maxxx@gmail.com. Feel free to contact with me.
