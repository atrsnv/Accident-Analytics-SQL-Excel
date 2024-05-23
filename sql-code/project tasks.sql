-- Коннектим БД, меняем типы данных там, где это нужно. (0)

USE accidents_and_vehicles;

SELECT * FROM accident;
SELECT * FROM vehicle;

ALTER TABLE vehicle
ALTER COLUMN AgeVehicle INTEGER;

-- Сколько ДТП происходит в сельской местности или в городах? (6)а

SELECT
	area,
	COUNT(AccidentIndex) AS 'Количество ДТП в разных видах местности'
FROM
	accident
GROUP BY area 

-- В какой день недели происходит наименьшее кол-во ДТП? (7)

SELECT
	Day, 
	COUNT(AccidentIndex) AS 'Количество инцедентов по дням недели'
FROM
	accident 
GROUP BY Day
ORDER BY COUNT(AccidentIndex) ASC;

-- Каков средний возраст транспортного средства в аварии, в зависимости от типа транспорта? (8)

SELECT
	VehicleType,
	COUNT(AccidentIndex) AS 'Количество инцедентов',
	FORMAT(AVG(CAST(AgeVehicle AS DECIMAL)), '0') 'Средний возраст автомобиля'
FROM 
	vehicle
WHERE
	 AgeVehicle IS NOT NULL
GROUP BY 
	VehicleType
ORDER BY 'Средний возраст автомобиля' DESC;

-- Могу ли я определить какие-либо тенденции в среднем значении ДТП, опираясь на состояние транспортных средств? (2)
SELECT 
	AgeGroup,
	COUNT(AccidentIndex) AS 'Количество ДТП',
	AVG(AgeVehicle) AS 'Средний возраст автомобилей'
FROM (
	SELECT
		AccidentIndex,
		AgeVehicle,
		CASE
			WHEN AgeVehicle BETWEEN 0 AND 4 THEN 'Новый'
			WHEN AgeVehicle BETWEEN 5 AND 10 THEN 'Средний износ'
			ELSE 'Изношенные'
		END AS AgeGroup
	FROM vehicle
) AS SubQuery
GROUP BY 
	AgeGroup
ORDER BY 'Количество ДТП' DESC;
	



-- Есть ли связь между погодными условиями и степени серьезности ДТП? (5)
 
 SELECT DISTINCT Severity FROM accident;
 -- Slight :  Легкое ДТП,
 -- Serious : ДТП средней тяжести,
 -- Fatal : Смертельные ДТП.`


 -- Легкие происшествия и их количество: 

SELECT
	WeatherConditions,
	COUNT(Severity) AS 'Количество ДТП'
FROM 
	accident
WHERE
	Severity = 'Slight'
GROUP BY
	WeatherConditions
ORDER BY
	COUNT(Severity) DESC;

 -- Тяжелые происшествия и их количество: 

 SELECT
	WeatherConditions,
	COUNT(Severity) AS 'Количество ДТП'
FROM 
	accident
WHERE
	Severity = 'Serious'
GROUP BY
	WeatherConditions
ORDER BY
	COUNT(Severity) DESC;

-- Смертельные происшествия и их количество:

 SELECT
	WeatherConditions,
	COUNT(Severity) AS 'Количество ДТП'
FROM 
	accident
WHERE
	Severity = 'Fatal'
GROUP BY
	WeatherConditions
ORDER BY
	COUNT(Severity) DESC;

-- Часто ли ДТП связаны с тем, что водитель левша? (4)

SELECT
	LeftHand,
	COUNT(AccidentIndex) AS  'Количество ДТП'
FROM
	vehicle 
GROUP BY 
	LeftHand
HAVING
	LeftHand IS NOT NULL
ORDER BY 'Количество ДТП' DESC

-- Существует ли связь между уровнем серьезности аварии и целью поездки? (1)

SELECT
	vehicle.JourneyPurpose,
	COUNT(accident.Severity) AS 'Количество несчастных случаев',
	CASE
		WHEN COUNT(accident.Severity) BETWEEN 0 AND 1100 THEN 'Низкий'
		WHEN COUNT(accident.Severity) BETWEEN 1101 AND 3000 THEN 'Средний'
		ELSE 'Высокий'
	END AS 'Уровень серьезности ДТП'
FROM 
	accident 
JOIN 
	vehicle ON vehicle.AccidentIndex = accident.AccidentIndex
GROUP BY 
	vehicle.JourneyPurpose
ORDER BY 
	COUNT(accident.Severity) DESC


-- Средний возраст машины, с учетом дневного света и места удара (3)

SELECT
	vehicle.PointImpact,
	accident.LightConditions,
	COUNT(accident.AccidentIndex) AS'Количество ДТП'
FROM 
	accident 
JOIN 
	vehicle ON vehicle.AccidentIndex = accident.AccidentIndex
GROUP BY 
	accident.LightConditions, vehicle.PointImpact
ORDER BY 
	'Количество ДТП' DESC;

