DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;
\c universe

CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    galaxy_type VARCHAR(50) NOT NULL,
    description TEXT,
    has_life BOOLEAN NOT NULL,
    distance_from_earth NUMERIC(12,2) NOT NULL,
    discovered_year INT NOT NULL
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
    spectral_type VARCHAR(10) NOT NULL,
    is_variable BOOLEAN NOT NULL,
    magnitude NUMERIC(10,2) NOT NULL,
    age_millions INT NOT NULL,
    description TEXT
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    star_id INT NOT NULL REFERENCES star(star_id),
    planet_type VARCHAR(50) NOT NULL,
    has_life BOOLEAN NOT NULL,
    radius_km INT NOT NULL,
    orbital_period NUMERIC(8,2) NOT NULL,
    description TEXT
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    planet_id INT NOT NULL REFERENCES planet(planet_id),
    is_irregular BOOLEAN NOT NULL,
    radius_km INT NOT NULL,
    orbital_period NUMERIC(8,2) NOT NULL,
    discovered_year INT NOT NULL,
    notes TEXT
);

CREATE TABLE mission (
    mission_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    planet_id INT NOT NULL REFERENCES planet(planet_id),
    launched_year INT NOT NULL,
    success BOOLEAN NOT NULL,
    crewed BOOLEAN NOT NULL,
    notes TEXT
);

INSERT INTO galaxy (name, galaxy_type, description, has_life, distance_from_earth, discovered_year) VALUES
('Milky Way', 'Spiral', 'Our home galaxy with billions of stars.', TRUE, 0.00, 1609),
('Andromeda', 'Spiral', 'Nearest large galaxy to the Milky Way.', FALSE, 2537000.00, 964),
('Triangulum', 'Spiral', 'A smaller spiral galaxy in the Local Group.', FALSE, 3000000.00, 1923),
('Large Magellanic Cloud', 'Irregular', 'A satellite galaxy of the Milky Way.', FALSE, 163000.00, 1500),
('Sombrero', 'Spiral', 'A bright galaxy with a prominent dust lane.', FALSE, 29000000.00, 1781),
('Whirlpool', 'Spiral', 'A galaxy with a famous interacting companion.', FALSE, 23000000.00, 1773);

INSERT INTO star (name, galaxy_id, spectral_type, is_variable, magnitude, age_millions, description) VALUES
('Sun', 1, 'G2V', FALSE, -26.74, 4600, 'The star at the center of our solar system.'),
('Proxima Centauri', 1, 'M5.5Ve', TRUE, 11.13, 4500, 'Closest known star to the Sun.'),
('Rigel', 1, 'B8Ia', TRUE, 120000, 11000, 'A bright blue supergiant star.'),
('Antares', 1, 'M1.5Iab', TRUE, 89000, 12000, 'A red supergiant star in Scorpius.'),
('Alpha Centauri A', 1, 'G2V', FALSE, -0.01, 5900, 'A Sun-like star in the Alpha Centauri system.'),
('Vega', 1, 'A0V', FALSE, 0.03, 455, 'A bright star in the Lyra constellation.');

INSERT INTO planet (name, star_id, planet_type, has_life, radius_km, orbital_period, description) VALUES
('Mercury', 1, 'Terrestrial', FALSE, 2439, 88.00, 'Small rocky planet closest to the Sun.'),
('Venus', 1, 'Terrestrial', FALSE, 6052, 224.70, 'Hottest planet with thick atmosphere.'),
('Earth', 1, 'Terrestrial', TRUE, 6371, 365.25, 'Our home planet.'),
('Mars', 1, 'Terrestrial', FALSE, 3390, 687.00, 'The red planet.'),
('Jupiter', 1, 'Gas Giant', FALSE, 69911, 4332.59, 'Largest planet in our solar system.'),
('Saturn', 1, 'Gas Giant', FALSE, 58232, 10759.22, 'Planet with prominent rings.'),
('Uranus', 1, 'Ice Giant', FALSE, 25362, 30688.50, 'A tilted ice giant planet.'),
('Neptune', 1, 'Ice Giant', FALSE, 24622, 60182.00, 'Farthest planet in our solar system.'),
('Proxima b', 2, 'Terrestrial', FALSE, 7150, 11.19, 'An exoplanet orbiting Proxima Centauri.'),
('Rigel I', 3, 'Gas Giant', FALSE, 78000, 400.00, 'A massive gas giant around Rigel.'),
('Antares B', 4, 'Terrestrial', FALSE, 5200, 210.00, 'A rocky planet near Antares.'),
('Vega 1', 6, 'Ice Giant', FALSE, 29000, 460.00, 'A distant cold world orbiting Vega.');

INSERT INTO moon (name, planet_id, is_irregular, radius_km, orbital_period, discovered_year, notes) VALUES
('Moon', 3, FALSE, 1737, 27.32, 1610, 'Earth''s only natural satellite.'),
('Phobos', 4, TRUE, 11, 0.32, 1877, 'Mars'' innermost moon.'),
('Deimos', 4, TRUE, 6, 1.26, 1877, 'Mars'' smaller outer moon.'),
('Io', 5, FALSE, 1821, 1.77, 1610, 'Volcanically active moon of Jupiter.'),
('Europa', 5, FALSE, 1560, 3.55, 1610, 'Ice-covered moon of Jupiter.'),
('Ganymede', 5, FALSE, 2634, 7.15, 1610, 'Largest moon in the solar system.'),
('Callisto', 5, FALSE, 2410, 16.69, 1610, 'Heavily cratered moon of Jupiter.'),
('Titan', 6, FALSE, 2575, 15.95, 1655, 'Largest moon of Saturn with a thick atmosphere.'),
('Enceladus', 6, FALSE, 252, 1.37, 1789, 'Icy moon with geysers.'),
('Mimas', 6, FALSE, 198, 0.94, 1789, 'Moon with a large crater like Death Star.'),
('Triton', 8, TRUE, 1353, -5.88, 1846, 'Neptune''s largest retrograde moon.'),
('Naiad', 8, TRUE, 33, 0.29, 1989, 'Innermost moon of Neptune.'),
('Thalassa', 8, TRUE, 41, 0.31, 1989, 'Second moon of Neptune.'),
('Dione', 6, FALSE, 561, 2.74, 1684, 'Medium-sized moon of Saturn.'),
('Rhea', 6, FALSE, 764, 4.52, 1672, 'Second-largest moon of Saturn.'),
('Iapetus', 6, TRUE, 734, 79.32, 1671, 'Moon with a dramatic equatorial ridge.'),
('Rhea II', 6, TRUE, 150, 6.00, 1900, 'Hypothetical captured asteroid moon.'),
('Europa II', 5, TRUE, 120, 4.00, 1905, 'Fictional small moon near Europa.'),
('Ganymede II', 5, TRUE, 140, 7.50, 1908, 'Fictional secondary moon of Jupiter.'),
('Luna X', 3, TRUE, 400, 50.00, 1950, 'Fictional distant moon of Earth.');

INSERT INTO mission (name, planet_id, launched_year, success, crewed, notes) VALUES
('Apollo 11', 3, 1969, TRUE, TRUE, 'First crewed mission to the Moon.'),
('Voyager 1', 8, 1977, TRUE, FALSE, 'Flyby mission that left the solar system.'),
('Cassini-Huygens', 6, 1997, TRUE, FALSE, 'Studied Saturn and dropped a probe to Titan.');
