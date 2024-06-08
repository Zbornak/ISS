//
//  File.swift
//  
//
//  Created by Mark Strijdom on 08/06/2024.
//

import Foundation

let facts = """
[
    {
        "id": 1,
        "description": "The ISS has spent over 25 years in orbit"
    },
    {
        "id": 2,
        "description": "Over 270 Astronauts have visited the ISS"
    },
    {
        "id": 3,
        "description": "The ISS is larger than a 6-bedroom house with six sleeping quarters, two bathrooms, a gym, and a 360-degree view bay window"
    },
    {
        "id": 4,
        "description": "An international partnership of five space agencies from 15 countries operates the ISS"
    },
    {
        "id": 5,
        "description": "The ISS has been continuously occupied since November 2000"
    },
    {
        "id": 6,
        "description": "An international crew of 7 people live and work while traveling at a speed of five miles per second, orbiting Earth about every 90 minutes"
    },
    {
        "id": 7,
        "description": "In 24 hours, the ISS makes 16 orbits of Earth, traveling through 16 sunrises and sunsets"
    },
    {
        "id": 8,
        "description": "Peggy Whitson set the U.S. record for spending the most total time living and working in space at 665 days on Sept. 2, 2017"
    },
    {
        "id": 9,
        "description": "To mitigate the loss of muscle and bone mass in the human body in microgravity, the Astronauts work out at least 2 hours a day"
    },
    {
        "id": 10,
        "description": "Astronauts and Cosmonauts regularly conduct spacewalks for ISS construction, maintenance and upgrades"
    },
    {
        "id": 11,
        "description": "The solar array wingspan (356 feet, 109 meters) is longer than the world’s largest passenger aircraft, the Airbus A380 (262 feet, 80 meters)"
    },
    {
        "id": 12,
        "description": "The large modules and other pieces of the ISS were delivered on 42 assembly flights, 37 on the U.S. space shuttles and five on Russian Proton/Soyuz rockets"
    },
    {
        "id": 13,
        "description": "The ISS is 356 feet (109 meters) end-to-end, 1 yard shy of the full length of an American football field including the end zones"
    },
    {
        "id": 14,
        "description": "8 miles of wire connects the electrical power system aboard the ISS"
    },
    {
        "id": 15,
        "description": "The 55-foot robotic Canadarm2 has seven different joints and two end-effectors, or hands, and is used to move entire modules, deploy science experiments and even transport spacewalking Astronauts"
    },
    {
        "id": 16,
        "description": "8 spaceships can be connected to the ISS at once"
    },
    {
        "id": 17,
        "description": "A spacecraft can arrive at the ISS as soon as four hours after launching from Earth"
    },
    {
        "id": 18,
        "description": "4 different cargo spacecraft deliver science, cargo and supplies: Northrop Grumman’s Cygnus, SpaceX’s Dragon, JAXA’s HTV, and the Russian Progress"
    },
    {
        "id": 19,
        "description": "Through Expedition 60, the microgravity laboratory has hosted nearly 3,000 research investigations from researchers in more than 108 countries"
    },
    {
        "id": 20,
        "description": "The ISS’s orbital path takes it over 90 percent of the Earth’s population, with astronauts taking millions of images of the planet below"
    },
    {
        "id": 21,
        "description": "More than 20 different research payloads can be hosted outside the ISS at once, including Earth sensing equipment, materials science payloads, particle physics experiments like the Alpha Magnetic Spectrometer-02 and more"
    },
    {
        "id": 22,
        "description": "The ISS travels an equivalent distance to the Moon and back in about a day"
    },
    {
        "id": 23,
        "description": "The Water Recovery System reduces crew dependence on water delivered by a cargo spacecraft by 65 percent – from about 1 gallon a day to 1/3 of a gallon"
    },
    {
        "id": 24,
        "description": "On-orbit software monitors approximately 350,000 sensors, ensuring ISS and crew health and safety"
    },
    {
        "id": 25,
        "description": "The ISS has an internal pressurised volume equal that of a Boeing 747"
    },
    {
        "id": 26,
        "description": "More than 50 computers control the systems on the ISS"
    },
    {
        "id": 27,
        "description": "More than 3 million lines of software code on the ground support more than 1.5 million lines of flight software code"
    },
    {
        "id": 28,
        "description": "In the ISS’s U.S. segment alone, more than 1.5 million lines of flight software code run on 44 computers communicating via 100 data networks transferring 400,000 signals (e.g. pressure or temperature measurements, valve positions, etc.)"
    },
    {
        "id": 29,
        "description": "Since 2000, the station evolved from an outpost into a highly capable microgravity laboratory. Results are compounding, new benefits are emerging, and the 3rd decade is building on research"
    },
    {
        "id": 30,
        "description": "The ISS is divided into two sections: the Russian Orbital Segment (ROS) assembled by Roscosmos, and the US Orbital Segment, assembled by NASA, JAXA, ESA and CSA"
    },
    {
        "id": 31,
        "description": "The ISS is expected to have additional modules (the Axiom Orbital Segment, for example) before being de-orbited by a dedicated NASA spacecraft in January 2031"
    },
    {
        "id": 32,
        "description": "The ISS was originally intended to be a laboratory, observatory, and factory while providing transportation, maintenance, and a low Earth orbit staging base for possible future missions to the Moon, Mars, and asteroids"
    },
    {
        "id": 33,
        "description": "Scientists on Earth have timely access to the data produced onboard the ISS and can suggest experimental modifications to the crew"
    },
    {
        "id": 34,
        "description": "The assembly of the ISS, a major endeavour in space architecture, began in November 1998"
    },
    {
        "id": 35,
        "description": "The first module of the ISS (Zarya) was launched on 20 November 1998 on an autonomous Russian Proton rocket. It provided propulsion, attitude control, communications, and electrical power"
    },
    {
        "id": 36,
        "description": "The first resident crew of the ISS, Expedition 1, arrived in November 2000 on Soyuz TM-31"
    },
    {
        "id": 37,
        "description": "The expansion schedule of the ISS was interrupted in 2003 by the Space Shuttle Columbia disaster and a resulting hiatus in flights"
    },
    {
        "id": 38,
        "description": "Hydrogen gas is constantly vented overboard by the ISS’s oxygen generators"
    },
    {
        "id": 39,
        "description": "The ISS has 18 pressurised modules:  Zarya, Unity, Zvezda, Destiny, Quest, Poisk, Harmony, Tranquility, Columbus, Kibo, Cupola, Rassvet, Science Airlock, Bigelow, Leonardo, Bishop Airlock Module, Nauka and Prichal"
    },
    {
        "id": 40,
        "description": "Double-sided solar arrays provide electrical power to the ISS. These bifacial cells collect direct sunlight on one side and light reflected off from the Earth on the other"
    },
    {
        "id": 41,
        "description": "The ISS is equipped with about 100 IBM/Lenovo ThinkPad and HP ZBook 15 laptop computers. Heat generated by the laptops does not rise but stagnates around the laptop, so additional forced ventilation is required"
    },
    {
        "id": 42,
        "description": "The operating system used for key station functions is the Debian Linux distribution. The migration from Microsoft Windows to Linux was made in May 2013 for reasons of reliability, stability and flexibility"
    },
    {
        "id": 43,
        "description": "NASA Astronaut T. J. Creamer made the first Tweet from space using the ISS’s Internet connection"
    },
    {
        "id": 44,
        "description": "As of June 2023, 13 space tourists have visited the ISS; 9 were transported to the ISS on Russian Soyuz spacecraft, and 4 were transported on American SpaceX Dragon 2 spacecraft"
    },
    {
        "id": 45,
        "description": "The ISS is not owned by one single nation and is a co-operative programme between Europe, the United States, Russia, Canada and Japan"
    },
    {
        "id": 46,
        "description": "The ISS costs about $3 billion per year for NASA to operate, roughly a third of the human spaceflight budget"
    },
    {
        "id": 47,
        "description": "Russia says it will withdraw from the ISS after 2024 to focus on building its own space station in 2028"
    },
    {
        "id": 48,
        "description": "The ISS is 356 feet (109 meters) end-to-end with a mass of 925,335 pounds (419,725 kilograms) without visiting vehicles"
    },
    {
        "id": 49,
        "description": "At night, the ISS is visible from Earth, appearing as a luminous moving point of light and rivaling the brilliant planet Venus in brightness"
    },
    {
        "id": 50,
        "description": "In 2009 the ISS hosted the biggest ever space gathering: 13 people during NASA's STS-127 shuttle mission aboard Endeavour"
    }
]


"""
