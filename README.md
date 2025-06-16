
<img src="BusTracker/Assets.xcassets/AppIcon.appiconset/logo.png" alt="BusTrackerLogo" height=256/>

# BusTracker App

[![iOS](https://img.shields.io/badge/iOS-000000?&logo=apple&logoColor=white)](https://apple.com/ios/)
[![App Store](https://img.shields.io/badge/App_Store-0D96F6?logo=app-store&logoColor=white)](https://appstore.com/)
[![Swift](https://img.shields.io/badge/Swift-F54A2A?logo=swift&logoColor=white)](https://www.swift.org)
[![GitHub](https://img.shields.io/badge/GitHub-%23121011.svg?logo=github&logoColor=white)](https://github.com/zwill22/BusTracker)
[![XMLCoder](https://img.shields.io/badge/XML-767C52?logo=xml&logoColor=fff)](https://github.com/CoreOffice/XMLCoder.git)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/zwill22/bustracker)](https://github.com/zwill22/BusTracker/issues)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?&logo=buy-me-a-coffee&logoColor=black)](https://coff.ee/zmwill)
[![License: MIT](https://img.shields.io/github/license/zwill22/bustracker)](https://github.com/zwill22/bustracker/blob/main/LICENSE)



This is a bus tracking app for UK Bus services using location data from 
the [Bus Open Data Service](https://www.bus-data.dft.gov.uk).
This app aims to provide users with real-time location data for buses across the UK.

<img src="Info/Images/MainView.png" alt="Main view showing buses around Cardiff, UK" height=720/>
<img src="Info/Images/OperatorList.png" alt="View showing list of transport operators" height=720/>
<img src="Info/Images/StopView.png" alt="View showing stops and stations around Cardiff, UK" height=720/>

The app can be used to find bus services currently running, information about transport operators, and
the locations of bus stops and other transport access locations.

## Data Sources

- Bus location data: [Bus Open Data Service API](https://www.bus-data.dft.gov.uk)
- Transport operator data: [NOC Database](https://www.travelinedata.org.uk/traveline-open-data/transport-operations/about-2/)
- Transport Stop data: [National Public Transport Access Nodes API](https://naptan.api.dft.gov.uk/)

## Dependencies

- [Open Bus API](https://github.com/zwill22/OpenBusAPI.git): Data access
- [XMLCoder library](https://github.com/CoreOffice/XMLCoder.git): Decoding location data

The Bus location data is in XML format using the
[SIRI-VM](https://www.gov.uk/government/publications/technical-guidance-publishing-location-data-using-the-bus-open-data-service-siri-vm)
standard.

## Using the App

The main view shows a list of vehicles with their current location displayed on the map (see above).
Each item in the list displays the bus number, its destination, where it departed from and at what time, and 
the operator.

Clicking on an item in the bus list directs the user to a more detailed view about a particular bus (see below).
This includes its current location and the location of its destination.
More detailed information is provided about its location, origin, and when the information was obtained.

<img src="Info/Images/BusDetailView.png" alt="View showing details of a bus in Cardiff, UK" height=720/>
<img src="Info/Images/OperatorDetailView.png" alt="View showing transport operator details" height=720/>
<img src="Info/Images/StopDetailView.png" alt="View showing details of a UK bus station" height=720/>

The bus detail view includes a link to details about the bus operator including their website, contact information,
and social media (see above).

The operators tab (see top) includes a searchable list of all UK transport operators with links to the same detail
view as previously mentioned.

The stops tab provides a view of transport stops in the area and their location annotated by type (see top).
Clicking a stop from the list provides a more detailed view of the stop's location.

A settings tab is also included to adjust default settings (this is not advised) and provides information and links.

## Acknowledgements

I would like to thank the UK's public transport system for helping me conceive this app.
If I had never missed a bus which left early and had to wait half an hour for another,
I would never have made this app.

Thank you to anyone who has used the app. If you have any suggestions, issues, bugs, or notes, please report them in the
[issues tab](https://github.com/zwill22/BusTracker/issues), or check the 
[issues list](Info/Issues.md).
If you found the app use, please consider supporting my work:

<img src="BusTracker/Assets.xcassets/buymeacoffee.imageset/coffee.png" alt="Buy Me A Cherry Cola" height="48">

