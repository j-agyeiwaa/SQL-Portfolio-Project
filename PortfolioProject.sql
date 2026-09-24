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

--SELECT date, SUM(new_cases) AS TotalNewCases, SUM(CAST(new_deaths AS INT)) AS TotalNewDeaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases) * 100 AS DeathPercentage
--FROM PORTFOLIOPROJECT.DBO.COVIDDEATHS
--WHERE continent IS NOT NULL AND new_cases > 0
--GROUP BY date
--ORDER BY 1,2

--SELECT Deaths.continent, Deaths.location,Deaths.date, Deaths.population, Vac.new_vaccinations, SUM(CAST(Vac.new_vaccinations AS INT)) OVER (PARTITION BY Deaths.location ORDER BY Deaths.location,Deaths.date) AS TotalNewVaccinations
--FROM CovidDeaths Deaths
--JOIN CovidVaccinations Vac
--	ON Deaths.location = Vac.location
--	AND Deaths.date = Vac.date
--WHERE Deaths.continent IS NOT NULL
--ORDER BY 2,3

--WITH PopvsVac (Continent, Location, Date, Population, NewVaccinations,TotalNewVaccinations) AS 
--(
--SELECT Deaths.continent, Deaths.location,Deaths.date, Deaths.population, Vac.new_vaccinations, SUM(CAST(Vac.new_vaccinations AS INT)) OVER (PARTITION BY Deaths.location ORDER BY Deaths.location,Deaths.date) AS TotalNewVaccinations
--FROM CovidDeaths Deaths
--JOIN CovidVaccinations Vac
--	ON Deaths.location = Vac.location
--	AND Deaths.date = Vac.date
--WHERE Deaths.continent IS NOT NULL
--)

--SELECT *, (TotalNewVaccinations/Population)*100 AS TotalNewVacPerPopulation
--FROM PopvsVac

--DROP TABLE IF EXISTS #PercentPopulationVaccinated
--CREATE TABLE #PercentPopulationVaccinated
--(
--Continent nvarchar(255),
--Location nvarchar(255),
--Date datetime,
--Population numeric,
--New_Vaccinations numeric,
--TotalNewVaccinations numeric
--)

--INSERT INTO #PercentPopulationVaccinated
--SELECT Deaths.continent, Deaths.location,Deaths.date, Deaths.population, Vac.new_vaccinations, SUM(CAST(Vac.new_vaccinations AS INT)) OVER (PARTITION BY Deaths.location ORDER BY Deaths.location,Deaths.date) AS TotalNewVaccinations
--FROM CovidDeaths Deaths
--JOIN CovidVaccinations Vac
--	ON Deaths.location = Vac.location
--	AND Deaths.date = Vac.date
--WHERE Deaths.continent IS NOT NULL

--SELECT *, (TotalNewVaccinations/Population)*100 AS TotalNewVacPerPopulation
--FROM #PercentPopulationVaccinated

--SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathPercentage
--FROM CovidDeaths
--WHERE continent IS NOT NULL
--ORDER BY 1,2

--SELECT *
--FROM #PercentPopulationVaccinated

CREATE VIEW PercentPopulationVaccinated AS
SELECT Deaths.continent, Deaths.location,Deaths.date, Deaths.population, Vac.new_vaccinations, SUM(CAST(Vac.new_vaccinations AS INT)) OVER (PARTITION BY Deaths.location ORDER BY Deaths.location,Deaths.date) AS TotalNewVaccinations
FROM CovidDeaths Deaths
JOIN CovidVaccinations Vac
	ON Deaths.location = Vac.location
	AND Deaths.date = Vac.date
WHERE Deaths.continent IS NOT NULL

SELECT * 
FROM PercentPopulationVaccinated