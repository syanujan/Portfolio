Select *
from [Portfolio Project]..CovidDeaths
where continent is not null
order by 3,4

--Select *
--from [Portfolio Project]..CovidVaccinations
--order by 3,4

-- Select data that we are going to be using
Select Location,date, total_cases, new_cases, total_deaths, population
From [Portfolio Project]..CovidDeaths
ORDER BY 1,2


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
Select Location,date, total_cases, total_deaths,
(CONVERT(float,total_deaths)/NULLIF(CONVERT(float,total_cases),0))*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
where continent is not null
--Where location like '%states%'
ORDER BY 1,2

-- Looking at Total Cases vs Total Population
Select Location,date, population, total_cases, 
(CONVERT(float,total_cases)/NULLIF(CONVERT(float,population),0))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths
where continent is not null
ORDER BY 1,2

-- Finding country that has the highest infection rate compared to population
Select Location, population, date, MAX(total_cases) as HighestInfectionCount, 
MAX((CONVERT(float,total_cases)/NULLIF(CONVERT(float,population),0)))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths
where continent is not null
Group by Location,Population,date
ORDER BY PercentPopulationInfected desc

-- Showing countries with the highest death count per Population
Select Location, MAX(cast(total_deaths as int)) as HighestDeathCount 
From [Portfolio Project]..CovidDeaths
where continent is not null
Group by Location
ORDER BY HighestDeathCount desc

-- Showing countries with the highest death count per Population
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount 
From [Portfolio Project]..CovidDeaths
where continent is not null
Group by continent
ORDER BY TotalDeathCount desc 

-- GLOBAL NUMBERS
Select date, SUM(cast(new_cases as int)) as total_cases,SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/NULLIF(SUM(cast(new_cases as int)),0)  
From [Portfolio Project]..CovidDeaths 
group by date
ORDER BY date,total_cases,total_deaths

