//
//  TestData.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

let testBusData: Data = """
<Siri version="2.0" xmlns="http://www.siri.org.uk/siri" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.siri.org.uk/siri http://www.siri.org.uk/schema/2.0/xsd/siri.xsd">
  <ServiceDelivery>
    <ResponseTimestamp>2025-04-17T11:11:11.437+00:00</ResponseTimestamp>
    <ProducerRef>FakeDataSource</ProducerRef>
    <VehicleMonitoringDelivery>
      <ResponseTimestamp>2025-04-17T11:11:11.437+00:00</ResponseTimestamp>
      <RequestMessageRef>1234567890</RequestMessageRef>
      <ValidUntil>2025-04-17T11:22:22.437+00:00</ValidUntil>
      <ShortestPossibleCycle>Cycle</ShortestPossibleCycle>
      <VehicleActivity>
        <RecordedAtTime>2025-04-17T11:11:00+00:00</RecordedAtTime>
        <ItemIdentifier>SCBODS:VEHICLESTATUSRT:123456:654321</ItemIdentifier>
        <ValidUntilTime>2025-04-17T11:22:22.437+00:00</ValidUntilTime>
        <MonitoredVehicleJourney>
          <LineRef>111</LineRef>
          <DirectionRef>inbound</DirectionRef>
          <FramedVehicleJourneyRef>
            <DataFrameRef>2025-04-17</DataFrameRef>
            <DatedVehicleJourneyRef>1234</DatedVehicleJourneyRef>
          </FramedVehicleJourneyRef>
          <PublishedLineName>123</PublishedLineName>
          <OperatorRef>OPTA</OperatorRef>
          <OriginRef>2800S29001D</OriginRef>
          <OriginName>A Bus Station</OriginName>
          <DestinationRef>2800S42061D</DestinationRef>
          <DestinationName>California St</DestinationName>
          <OriginAimedDepartureTime>2025-04-17T10:55:00+00:00</OriginAimedDepartureTime>
          <Monitored>true</Monitored>
          <VehicleLocation>
            <Longitude>-122.00190</Longitude>
            <Latitude>37.3312</Latitude>
          </VehicleLocation>
          <Bearing>156</Bearing>
          <VehicleRef>OpA-10001</VehicleRef>
        </MonitoredVehicleJourney>
        <Extensions>
          <VehicleJourney>
            <DriverRef>10001</DriverRef>
          </VehicleJourney>
        </Extensions>
      </VehicleActivity>
      <VehicleActivity>
        <RecordedAtTime>2025-04-17T11:11:11+00:00</RecordedAtTime>
        <ItemIdentifier>SCBODS:VEHICLESTATUSRT:789012:345678</ItemIdentifier>
        <ValidUntilTime>2025-04-17T11:22:22.437+00:00</ValidUntilTime>
        <MonitoredVehicleJourney>
          <LineRef>X1</LineRef>
          <DirectionRef>outbound</DirectionRef>
          <FramedVehicleJourneyRef>
            <DataFrameRef>2025-04-17</DataFrameRef>
            <DatedVehicleJourneyRef>111</DatedVehicleJourneyRef>
          </FramedVehicleJourneyRef>
          <PublishedLineName>X1</PublishedLineName>
          <OperatorRef>OPTB</OperatorRef>
          <OriginRef>1234CA246802</OriginRef>
          <OriginName>Bus Interchange</OriginName>
          <DestinationRef>2800S42022C</DestinationRef>
          <DestinationName>Final Destination Gb</DestinationName>
          <OriginAimedDepartureTime>2025-04-17T10:25:00+00:00</OriginAimedDepartureTime>
          <Monitored>true</Monitored>
          <VehicleLocation>
            <Longitude>-122.0087</Longitude>
            <Latitude>37.34002</Latitude>
          </VehicleLocation>
          <Bearing>30</Bearing>
          <VehicleRef>SCMY-12321</VehicleRef>
        </MonitoredVehicleJourney>
        <Extensions>
          <VehicleJourney>
            <DriverRef>123456</DriverRef>
          </VehicleJourney>
        </Extensions>
      </VehicleActivity>
    </VehicleMonitoringDelivery>
  </ServiceDelivery>
</Siri>
""".data(using: .utf8)!
