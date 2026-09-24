--SELECT *
--FROM PORTFOLIOPROJECT.DBO.COVIDDEATHS
--ORDER BY 3,4

--SELECT *
--FROM PORTFOLIOPROJECT.DBO.COVIDVACCINATIONS
--ORDER BY 3,4

--SELECT location, date, total_cases, new_cases, total_deaths, population
--FROM PORTFOLIOPROJECT.DBO.COVIDDEATHS
--ORDER BY 1,2

--SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
--FROM PORTFOLIOPROJECT.DBO.COVIDDEATHS
--WHERE total_cases > 0 AND location like '%states%'
--ORDER BY 1,2 

--SELECT location, date, total_cases, population, (total_cases/population)*100 AS CasePercentage
--FROM PORTFOLIOPROJECT.DBO.COVIDDEATHS
----WHERE total_cases > 0 AND location like '%states%'
--ORDER BY 1,2 

--SELECT location, MAX(total_cases) AS InfectionCount, MAX((total_cases/population))*100 AS PercentagePopulationInfected
--FROM PORTFOLIOPROJECT.DBO.COVIDDEATHS
--GROUP BY location, population
--ORDER BY PercentagePopulationInfected DESC

--SELECT location, MAX(total_deaths) AS TotalDeathCount
--FROM PORTFOLIOPROJECT.DBO.COVIDDEATHS
--GROUP BY location
--ORDER BY TotalDeathCount DESC

--SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
--FROM PORTFOLIOPROJECT.DBO.COVIDDEATHS
--WHERE continent is not null
--GROUP BY continent
--ORDER BY TotalDeathCount DESC

SELECT date, SUM(new_cases) AS TotalNewCases, SUM(CAST(new_deaths AS INT)) AS TotalNewDeaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases) * 100 AS DeathPercentage
FROM PORTFOLIOPROJECT.DBO.COVIDDEATHS
WHERE continent IS NOT NULL AND new_cases > 0
GROUP BY date
ORDER BY 1,2