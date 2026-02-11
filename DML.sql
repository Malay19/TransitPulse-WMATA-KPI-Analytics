--1. Which WMATA metro lines experience the highest number of service incidents, and what are their primary causes?
SELECT 
    L.lineName,
    S.primaryCause,
    SUM(S.incidentCount) AS totalIncidents
FROM Team13.ServiceIncident S
JOIN Team13.TransitLine L 
      ON S.lineId = L.lineId
GROUP BY L.lineName, S.primaryCause
ORDER BY totalIncidents DESC;


--2. Which WMATA stations recorded the highest annual crime totals, and which crime types were most frequent at each station?
SELECT 
    ST.stationId,
    ST.stationName,
    C.crimeTypeName,
    SC.incidentCount AS totalIncidents
FROM Team13.StationCrime SC
JOIN Team13.MetroStation ST 
      ON SC.stationId = ST.stationId
JOIN Team13.CrimeCategory C 
      ON SC.crimeTypeId = C.crimeTypeId
ORDER BY totalIncidents DESC;


--3. What are the most common crime types across the WMATA system?
SELECT 
    C.crimeTypeName,
    SUM(SC.incidentCount) AS totalIncidents
FROM Team13.StationCrime SC
JOIN Team13.CrimeCategory C 
      ON SC.crimeTypeId = C.crimeTypeId
GROUP BY C.crimeTypeName
ORDER BY totalIncidents DESC;


--4. How has WMATA ridership changed month-to-month across Metrorail, Metrobus, and MetroAccess?
SELECT 
    R.mode,
    R.dateId,
    R.totalRidership,
    LAG(R.totalRidership) OVER (PARTITION BY R.mode ORDER BY R.dateId) AS prevMonthRidership,
    ROUND(
        100.0 * 
        (R.totalRidership - LAG(R.totalRidership) OVER (PARTITION BY R.mode ORDER BY R.dateId))
        / NULLIF(LAG(R.totalRidership) OVER (PARTITION BY R.mode ORDER BY R.dateId), 0), 
        2
    ) AS percentChangePrevMonth
FROM Team13.SystemRidership R
ORDER BY R.mode, R.dateId;


-- 5. Which WMATA metro lines maintain the highest on-time performance rates, and how do these lines compare?
SELECT 
    L.lineName,
    O.scheduledTrips,
    O.onTimeTrips,
    ROUND(100.0 * O.onTimeTrips / NULLIF(O.scheduledTrips, 0), 2) AS onTimePct
FROM Team13.OnTimePerformance O
JOIN Team13.TransitLine L 
      ON O.lineId = L.lineId
ORDER BY onTimePct DESC;


-- 6. How does station activity (entries/exits) relate to crime levels across WMATA stations?
SELECT 
    SS.stationId,
    ST.stationName,
    SS.totalEntries + SS.totalExits AS totalActivity,
    COALESCE(SUM(SC.incidentCount), 0) AS totalCrimes
FROM Team13.StationSnapshot SS
JOIN Team13.MetroStation ST 
      ON SS.stationId = ST.stationId
LEFT JOIN Team13.StationCrime SC 
      ON SS.stationId = SC.stationId
GROUP BY 
    SS.stationId, 
    ST.stationName, 
    SS.totalEntries, 
    SS.totalExits
ORDER BY totalCrimes DESC;
