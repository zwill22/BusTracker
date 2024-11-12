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
    <ResponseTimestamp>2024-11-12T11:55:12.437+00:00</ResponseTimestamp>
    <ProducerRef>DepartmentForTransport</ProducerRef>
    <VehicleMonitoringDelivery>
      <ResponseTimestamp>2024-11-12T11:55:12.437+00:00</ResponseTimestamp>
      <RequestMessageRef>1cfe601f-b2cc-4d84-9e91-5ad9099ee338</RequestMessageRef>
      <ValidUntil>2024-11-12T12:00:12.437+00:00</ValidUntil>
      <ShortestPossibleCycle>PT5S</ShortestPossibleCycle>
      <VehicleActivity>
        <RecordedAtTime>2024-11-12T11:55:06+00:00</RecordedAtTime>
        <ItemIdentifier>SCBODS:VEHICLESTATUSRT:18056:128545</ItemIdentifier>
        <ValidUntilTime>2024-11-12T12:00:12.437+00:00</ValidUntilTime>
        <MonitoredVehicleJourney>
          <LineRef>471</LineRef>
          <DirectionRef>inbound</DirectionRef>
          <FramedVehicleJourneyRef>
            <DataFrameRef>2024-11-12</DataFrameRef>
            <DatedVehicleJourneyRef>1032</DatedVehicleJourneyRef>
          </FramedVehicleJourneyRef>
          <PublishedLineName>471</PublishedLineName>
          <OperatorRef>SCMY</OperatorRef>
          <OriginRef>2800S29001D</OriginRef>
          <OriginName>Heswall Bus Stn-D</OriginName>
          <DestinationRef>2800S42061D</DestinationRef>
          <DestinationName>Cook St (alighting)</DestinationName>
          <OriginAimedDepartureTime>2024-11-12T10:55:00+00:00</OriginAimedDepartureTime>
          <Monitored>true</Monitored>
          <VehicleLocation>
            <Longitude>-2.988233</Longitude>
            <Latitude>53.405571</Latitude>
          </VehicleLocation>
          <Bearing>156</Bearing>
          <VehicleRef>SCMY-10882</VehicleRef>
        </MonitoredVehicleJourney>
        <Extensions>
          <VehicleJourney>
            <DriverRef>75942</DriverRef>
          </VehicleJourney>
        </Extensions>
      </VehicleActivity>
      <VehicleActivity>
        <RecordedAtTime>2024-11-12T11:54:55+00:00</RecordedAtTime>
        <ItemIdentifier>SCBODS:VEHICLESTATUSRT:18057:123281</ItemIdentifier>
        <ValidUntilTime>2024-11-12T12:00:12.437+00:00</ValidUntilTime>
        <MonitoredVehicleJourney>
          <LineRef>X1</LineRef>
          <DirectionRef>outbound</DirectionRef>
          <FramedVehicleJourneyRef>
            <DataFrameRef>2024-11-12</DataFrameRef>
            <DatedVehicleJourneyRef>333</DatedVehicleJourneyRef>
          </FramedVehicleJourneyRef>
          <PublishedLineName>X1</PublishedLineName>
          <OperatorRef>SCMY</OperatorRef>
          <OriginRef>0610CH19166</OriginRef>
          <OriginName>Bus Interchange</OriginName>
          <DestinationRef>2800S42042C</DestinationRef>
          <DestinationName>Whitechapel Gb</DestinationName>
          <OriginAimedDepartureTime>2024-11-12T10:25:00+00:00</OriginAimedDepartureTime>
          <Monitored>true</Monitored>
          <VehicleLocation>
            <Longitude>-3.014628</Longitude>
            <Latitude>53.385883</Latitude>
          </VehicleLocation>
          <Bearing>30</Bearing>
          <VehicleRef>SCMY-10883</VehicleRef>
        </MonitoredVehicleJourney>
        <Extensions>
          <VehicleJourney>
            <DriverRef>8501021</DriverRef>
          </VehicleJourney>
        </Extensions>
      </VehicleActivity>
    </VehicleMonitoringDelivery>
  </ServiceDelivery>
</Siri>
""".data(using: .utf8)!
