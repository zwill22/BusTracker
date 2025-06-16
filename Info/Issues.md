# Known Issues

The following is a list of known issues, bugs, and limitations with the BusTrackerApp.

- The bus position cannot be updated from the `BusDetailView`
- Only some operators have an implemented colour scheme
- All stops are listed, no matter how small. There is no way to filter the list
- Direction of travel is not included in `BusDetailView`, this is important for circular bus routes
- Bus stop details include a (fixed) position but do not include any navigation link
- Destinations and origins in bus details do not link to the stop details.
- No map interactivity
- Updated settings do not persist after restart
- No intermediate stop details, the app only shows the final destination but not the stops or the route.
- No timetable data
- Stops data dependent on bus data
- Operators data does not persist
- Positions not automatically refreshed
- Minimal accessibility information
- Not tested on all screens
