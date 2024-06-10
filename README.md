Introduction
===

This is sample app done in scope of technical task. It allows users to convert currencies using real-time exchange ratesconvert using api.evp.lt. App was built by using Swift, UIKit and Combine, without any other third party libraries.


Requirements
---

- iOS
	- iOS 16+
	- Xcode 15.2
	- Swift 5
- macOS
    - Ventura or higher
    

TODO list:
---

- Improve presentation layer
    - Reuse same UIView for source-target currency selection
    - Instead of using UIPickerView, better create seperate screen with a list of avaialble currencies
    - Move UIPickerView datasource out of ViewController
    - Instead of using 3 input @Published properties in VM, define separate struct containing them, and observe any changes of it
    - Present more elegant custom error message view
    - Make UI looks better by applying provided design
- Improve domain layer
    - Map response objects from Data layer, into Domain objects
    - Map all errors from Data layer, into Domain errors
- Improve data layer
    - Extend error handling for more error codes
    - Create separate data source for supported currencies
- Move each layer to seperate package
- Document each iterface described by protocol, as it was done for Repository
- Write UI/Unit tests for all parts containing logic
