# Accident-Analytics-SQL

![image](https://github.com/rezzstra/Accident-Analytics-SQL/assets/142921009/d406ac8a-3f98-402a-b8cf-303777a5d9ed)


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

### 2. Могу ли я определить какие-либо тенденции количестве ДТП, опираясь на состояние транспортных средств?

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
	AgeGroup
ORDER BY
	'Количество ДТП' DESC;
```

**Результат:** 


![image](https://github.com/rezzstra/Accident-Analytics-SQL/assets/142921009/3ba7f3b3-0d9b-404c-8d57-835c7b9b7606)

Из результатов данного запроса можно сделать вывод, что изношенные автомобили являются причиной наибольшего количества ДТП. Средний возраст таких автомобилей составляет 13 лет, что свидетельствует о необходимости более тщательного контроля за техническим состоянием стареющих транспортных средств. Меры по повышению технической безопасности и обязательные проверки технического состояния автомобилей могут способствовать снижению числа ДТП, а также улучшению общей безопасности на дорогах.

### 3. Сколько ДТП было совершенно, с учетом дневного света и местом удара? 

```SQL
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
```
**Результат**: 


![image](https://github.com/rezzstra/Accident-Analytics-SQL/assets/142921009/c98f9403-4901-4ec3-982c-97beddebb1bd)


Исходя из даныных запроса, можно сделать вывод, что наибольшее количество ДТП происходит днем, причем аварии в переднюю часть автомобиля занимают первое место. Это может свидетельствовать о том, что водители чаще допускают ошибки или несоблюдают правила дорожного движения днем, особенно при движении впереди. Гораздо реже ДТП происходят ночью. Возможно, это связано с недостаточной видимостью или усталостью водителей в ночное время. Поэтому необходимо обратить особое внимание на безопасность и освещение дорог в ночное время, а также на эффективные меры профилактики и контроля за водителями, движущимися в темное время суток.

### 4. Часто ли ДТП связаны с тем, что водитель левша?

```SQL
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
```

**Результат**: 


![image](https://github.com/rezzstra/Accident-Analytics-SQL/assets/142921009/5f6ba227-231d-4050-93ae-bcf13f93c282)

Судя по данным запроса, видно, что праворукие водители имеют большее количество дорожно-транспортных происшествий (ДТП) по сравнению с леворукими водителями. Это может быть связано с тем, что правши преобладают в общем объеме автолюбителей и, следовательно, вероятность попадания в аварию у них выше.

### 5. Есть ли связь между погодными условиями и степени серьезности ДТП?

```SQL
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
```

**Результат**: 


![image](https://github.com/rezzstra/Accident-Analytics-SQL/assets/142921009/91e79f36-a68e-4edc-b700-2432ff1b58cc)

