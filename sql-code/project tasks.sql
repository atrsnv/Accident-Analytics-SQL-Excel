-- ��������� ��, ������ ���� ������ ���, ��� ��� �����. (0)

USE accidents_and_vehicles;

SELECT * FROM accident;
SELECT * FROM vehicle;

ALTER TABLE vehicle
ALTER COLUMN AgeVehicle INTEGER;

-- ������� ��� ���������� � �������� ��������� ��� � �������? (6)�

SELECT
	area,
	COUNT(AccidentIndex) AS '���������� ��� � ������ ����� ���������'
FROM
	accident
GROUP BY area 

-- � ����� ���� ������ ���������� ���������� ���-�� ���? (7)

SELECT
	Day, 
	COUNT(AccidentIndex) AS '���������� ���������� �� ���� ������'
FROM
	accident 
GROUP BY Day
ORDER BY COUNT(AccidentIndex) ASC;

-- ����� ������� ������� ������������� �������� � ������, � ����������� �� ���� ����������? (8)

SELECT
	VehicleType,
	COUNT(AccidentIndex) AS '���������� ����������',
	FORMAT(AVG(CAST(AgeVehicle AS DECIMAL)), '0') '������� ������� ����������'
FROM 
	vehicle
WHERE
	 AgeVehicle IS NOT NULL
GROUP BY 
	VehicleType
ORDER BY '������� ������� ����������' DESC;

-- ���� �� � ���������� �����-���� ��������� � ������� �������� ���, �������� �� ��������� ������������ �������? (2)
SELECT 
	AgeGroup,
	COUNT(AccidentIndex) AS '���������� ���',
	AVG(AgeVehicle) AS '������� ������� �����������'
FROM (
	SELECT
		AccidentIndex,
		AgeVehicle,
		CASE
			WHEN AgeVehicle BETWEEN 0 AND 4 THEN '�����'
			WHEN AgeVehicle BETWEEN 5 AND 10 THEN '������� �����'
			ELSE '����������'
		END AS AgeGroup
	FROM vehicle
) AS SubQuery
GROUP BY 
	AgeGroup
ORDER BY '���������� ���' DESC;
	



-- ���� �� ����� ����� ��������� ��������� � ������� ����������� ���? (5)
 
 SELECT DISTINCT Severity FROM accident;
 -- Slight :  ������ ���,
 -- Serious : ��� ������� �������,
 -- Fatal : ����������� ���.`


 -- ������ ������������ � �� ����������: 

SELECT
	WeatherConditions,
	COUNT(Severity) AS '���������� ���'
FROM 
	accident
WHERE
	Severity = 'Slight'
GROUP BY
	WeatherConditions
ORDER BY
	COUNT(Severity) DESC;

 -- ������� ������������ � �� ����������: 

 SELECT
	WeatherConditions,
	COUNT(Severity) AS '���������� ���'
FROM 
	accident
WHERE
	Severity = 'Serious'
GROUP BY
	WeatherConditions
ORDER BY
	COUNT(Severity) DESC;

-- ����������� ������������ � �� ����������:

 SELECT
	WeatherConditions,
	COUNT(Severity) AS '���������� ���'
FROM 
	accident
WHERE
	Severity = 'Fatal'
GROUP BY
	WeatherConditions
ORDER BY
	COUNT(Severity) DESC;

-- ����� �� ��� ������� � ���, ��� �������� �����? (4)

SELECT
	LeftHand,
	COUNT(AccidentIndex) AS  '���������� ���'
FROM
	vehicle 
GROUP BY 
	LeftHand
HAVING
	LeftHand IS NOT NULL
ORDER BY '���������� ���' DESC

-- ���������� �� ����� ����� ������� ����������� ������ � ����� �������? (1)

SELECT
	vehicle.JourneyPurpose,
	COUNT(accident.Severity) AS '���������� ���������� �������',
	CASE
		WHEN COUNT(accident.Severity) BETWEEN 0 AND 1100 THEN '������'
		WHEN COUNT(accident.Severity) BETWEEN 1101 AND 3000 THEN '�������'
		ELSE '�������'
	END AS '������� ����������� ���'
FROM 
	accident 
JOIN 
	vehicle ON vehicle.AccidentIndex = accident.AccidentIndex
GROUP BY 
	vehicle.JourneyPurpose
ORDER BY 
	COUNT(accident.Severity) DESC


-- ������� ������� ������, � ������ �������� ����� � ����� ����� (3)

SELECT
	vehicle.PointImpact,
	accident.LightConditions,
	COUNT(accident.AccidentIndex) AS'���������� ���'
FROM 
	accident 
JOIN 
	vehicle ON vehicle.AccidentIndex = accident.AccidentIndex
GROUP BY 
	accident.LightConditions, vehicle.PointImpact
ORDER BY 
	'���������� ���' DESC;

