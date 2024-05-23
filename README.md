# Accident-Analytics-SQL

> Аварии и катастрофы - это всегда трагедии, которые оставляют глубокий отпечаток на обществе. Однако за этими происшествиями стоят важные данные, которые могут помочь нам понять, почему они происходят, и принять меры для предотвращения подобных ситуаций в будущем. В этом проекте мы проведем всесторонний анализ данных об авариях, чтобы выявить ключевые факторы, лежащие в основе этих событий.

**Инструменты:** Microsoft SQL Server, Excel

### 1. Существует ли связь между уровнем серьезности аварии и целью поездки?

```SQL
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
```

**Результат:** 


![image](https://github.com/rezzstra/Accident-Analytics-SQL/assets/142921009/63b37501-0b1f-4e52-8b70-dc6c38c50a4a)

Судя по данным запроса, большинство аварий происходят на дороге во время поездки на работу или с работы. Это может говорить о необходимости более внимательного вождения в этих ситуациях, а также о возможной необходимости улучшения безопасности дорожного движения в рабочие дни. Создание программ по повышению безопасности на дорогах в периоды пикового движения или проведение обучающих мероприятий для водителей может снизить количество аварий и повысить общий уровень безопасности на дорогах.

### 2. Могу ли я определить какие-либо тенденции в среднем значении ДТП, опираясь на состояние транспортных средств?

```SQL
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
	AgeGroup;
```

**Результат:** 


![image](https://github.com/rezzstra/Accident-Analytics-SQL/assets/142921009/3ba7f3b3-0d9b-404c-8d57-835c7b9b7606)
