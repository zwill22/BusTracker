# BusTracker

This is a bus tracking app for UK Bus services using the [Bus Open Data Service](https://www.bus-data.dft.gov.uk).
The aim of this project is to provide users with real-time information for buses across the UK.

## Dependencies

This app uses the UK's Buss Open Data Service API (https://www.bus-data.dft.gov.uk) -- specifically the Bus location data.
This data is in XML format using the [SIRI-VM](https://www.gov.uk/government/publications/technical-guidance-publishing-location-data-using-the-bus-open-data-service-siri-vm) standard.
This data is decoded using the XMLDecoder from the [XMLCoder library](https://github.com/CoreOffice/XMLCoder.git").
Additionally, [WrappingHStack](https://github.com/ksemianov/WrappingHStack.git) is used for some formatting.
