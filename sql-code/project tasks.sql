
USE accidents_and_vehicles;

SELECT * FROM accident;
SELECT * FROM vehicle;

ALTER TABLE vehicle
ALTER COLUMN AgeVehicle INTEGER;



SELECT
	area,
	COUNT(AccidentIndex) AS 'Êîëè÷åñòâî ÄÒÏ â ðàçíûõ âèäàõ ìåñòíîñòè'
FROM
	accident
GROUP BY area 



SELECT
	Day, 
	COUNT(AccidentIndex) AS 'Êîëè÷åñòâî èíöåäåíòîâ ïî äíÿì íåäåëè'
FROM
	accident 
GROUP BY Day
ORDER BY COUNT(AccidentIndex) ASC;


SELECT
	VehicleType,
	COUNT(AccidentIndex) AS 'Êîëè÷åñòâî èíöåäåíòîâ',
	FORMAT(AVG(CAST(AgeVehicle AS DECIMAL)), '0') 'Ñðåäíèé âîçðàñò àâòîìîáèëÿ'
FROM 
	vehicle
WHERE
	 AgeVehicle IS NOT NULL
GROUP BY 
	VehicleType
ORDER BY 'Ñðåäíèé âîçðàñò àâòîìîáèëÿ' DESC;


SELECT 
	AgeGroup,
	COUNT(AccidentIndex) AS 'Êîëè÷åñòâî ÄÒÏ',
	AVG(AgeVehicle) AS 'Ñðåäíèé âîçðàñò àâòîìîáèëåé'
FROM (
	SELECT
		AccidentIndex,
		AgeVehicle,
		CASE
			WHEN AgeVehicle BETWEEN 0 AND 4 THEN 'Íîâûé'
			WHEN AgeVehicle BETWEEN 5 AND 10 THEN 'Ñðåäíèé èçíîñ'
			ELSE 'Èçíîøåííûå'
		END AS AgeGroup
	FROM vehicle
) AS SubQuery
GROUP BY 
	AgeGroup
ORDER BY 'Êîëè÷åñòâî ÄÒÏ' DESC;
	



 
 SELECT DISTINCT Severity FROM accident;





SELECT
	WeatherConditions,
	COUNT(Severity) AS 'Êîëè÷åñòâî ÄÒÏ'
FROM 
	accident
WHERE
	Severity = 'Slight'
GROUP BY
	WeatherConditions
ORDER BY
	COUNT(Severity) DESC;



 SELECT
	WeatherConditions,
	COUNT(Severity) AS 'Êîëè÷åñòâî ÄÒÏ'
FROM 
	accident
WHERE
	Severity = 'Serious'
GROUP BY
	WeatherConditions
ORDER BY
	COUNT(Severity) DESC;



 SELECT
	WeatherConditions,
	COUNT(Severity) AS 'Êîëè÷åñòâî ÄÒÏ'
FROM 
	accident
WHERE
	Severity = 'Fatal'
GROUP BY
	WeatherConditions
ORDER BY
	COUNT(Severity) DESC;



SELECT
	LeftHand,
	COUNT(AccidentIndex) AS  'Êîëè÷åñòâî ÄÒÏ'
FROM
	vehicle 
GROUP BY 
	LeftHand
HAVING
	LeftHand IS NOT NULL
ORDER BY 'Êîëè÷åñòâî ÄÒÏ' DESC



SELECT
	vehicle.JourneyPurpose,
	COUNT(accident.Severity) AS 'Êîëè÷åñòâî íåñ÷àñòíûõ ñëó÷àåâ',
	CASE
		WHEN COUNT(accident.Severity) BETWEEN 0 AND 1100 THEN 'Íèçêèé'
		WHEN COUNT(accident.Severity) BETWEEN 1101 AND 3000 THEN 'Ñðåäíèé'
		ELSE 'Âûñîêèé'
	END AS 'Óðîâåíü ñåðüåçíîñòè ÄÒÏ'
FROM 
	accident 
JOIN 
	vehicle ON vehicle.AccidentIndex = accident.AccidentIndex
GROUP BY 
	vehicle.JourneyPurpose
ORDER BY 
	COUNT(accident.Severity) DESC




SELECT
	vehicle.PointImpact,
	accident.LightConditions,
	COUNT(accident.AccidentIndex) AS'Êîëè÷åñòâî ÄÒÏ'
FROM 
	accident 
JOIN 
	vehicle ON vehicle.AccidentIndex = accident.AccidentIndex
GROUP BY 
	accident.LightConditions, vehicle.PointImpact
ORDER BY 
	'Êîëè÷åñòâî ÄÒÏ' DESC;

