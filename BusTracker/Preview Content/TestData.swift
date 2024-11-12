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
    <ResponseTimestamp>2024-11-12T13:44:31.074+00:00</ResponseTimestamp>
    <ProducerRef>DepartmentForTransport</ProducerRef>
    <VehicleMonitoringDelivery>
      <ResponseTimestamp>2024-11-12T13:44:31.074+00:00</ResponseTimestamp>
      <RequestMessageRef>4ae316d2-c664-4a6e-8b02-1e21bf0e68be</RequestMessageRef>
      <ValidUntil>2024-11-12T13:49:31.074+00:00</ValidUntil>
      <ShortestPossibleCycle>PT5S</ShortestPossibleCycle>
      <VehicleActivity>
        <RecordedAtTime>2024-11-12T13:42:51+00:00</RecordedAtTime>
        <ItemIdentifier>90f0daad-f5a7-487e-9e24-43fc8f5f3028</ItemIdentifier>
        <ValidUntilTime>2024-11-12T13:49:31.074+00:00</ValidUntilTime>
        <MonitoredVehicleJourney>
          <LineRef>106</LineRef>
          <DirectionRef>outbound</DirectionRef>
          <FramedVehicleJourneyRef>
            <DataFrameRef>2024-11-12</DataFrameRef>
            <DatedVehicleJourneyRef>1300</DatedVehicleJourneyRef>
          </FramedVehicleJourneyRef>
          <PublishedLineName>106</PublishedLineName>
          <OperatorRef>A2BV</OperatorRef>
          <OriginRef>2800S24007B</OriginRef>
          <OriginName>Monk_Road</OriginName>
          <DestinationRef>2800S24003E</DestinationRef>
          <DestinationName>Dominick_House</DestinationName>
          <OriginAimedDepartureTime>2024-11-12T13:00:00+00:00</OriginAimedDepartureTime>
          <DestinationAimedArrivalTime>2024-11-12T13:42:00+00:00</DestinationAimedArrivalTime>
          <VehicleLocation>
            <Longitude>-3.046278</Longitude>
            <Latitude>53.419923</Latitude>
          </VehicleLocation>
          <BlockRef>8</BlockRef>
          <VehicleRef>A2BV-YJ60_KFC</VehicleRef>
        </MonitoredVehicleJourney>
        <Extensions>
          <VehicleJourney>
            <Operational>
              <TicketMachine>
                <TicketMachineServiceCode>106</TicketMachineServiceCode>
                <JourneyCode>1300</JourneyCode>
              </TicketMachine>
            </Operational>
            <VehicleUniqueId>5</VehicleUniqueId>
          </VehicleJourney>
        </Extensions>
      </VehicleActivity>
    </VehicleMonitoringDelivery>
  </ServiceDelivery>
</Siri>
""".data(using: .utf8)!
