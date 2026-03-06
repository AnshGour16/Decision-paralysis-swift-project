import Foundation

struct DisasterData: Sendable {
    static let shared = DisasterData()
    
    let allDisasters: [DisasterInfo] = [
        DisasterInfo(
            type: .earthquake,
            example: "2015 Nepal Earthquake",
            causes: "**Earthquakes** happen when energy is suddenly released from the Earth's crust, creating seismic waves that shake the ground. This energy builds up over a long time along plate boundaries until the stress is too much and the rocks finally break or slip.",
            contentList: [
                InfoSection(heading: "Immediate Survival: Drop, Cover, Hold On", points: [
                    "**DROP** down onto your hands and knees so you don't get knocked over.",
                    "**COVER** your head and neck with your arms. Try to crawl under a sturdy table or desk to protect yourself from falling objects.",
                    "**HOLD ON** to your shelter until the shaking stops. If your shelter moves, move with it.",
                    "**STAY INSIDE.** Don't run outside or stand in doorways, as things might fall on you."
                ], systemImage: "figure.walk"),
                InfoSection(heading: "Preparation", points: [
                    "**Secure** heavy furniture like bookshelves to the wall so they don't tip.",
                    "**Add latches** to cabinets to keep plates and heavy items from falling out.",
                    "**Find safe spots** in every room, like under a heavy desk.",
                    "**Store heavy items** on lower shelves."
                ], systemImage: "shield.fill"),
                InfoSection(heading: "What to do after", points: [
                    "**Watch for aftershocks.** These can happen right after the main quake.",
                    "**Check for injuries** before you try to help others.",
                    "**If you smell gas**, turn off the main valve if you can and get out fast.",
                    "**Use stairs**, not elevators, because the power might go out."
                ], systemImage: "cross.case.fill")
            ]
        ),
        
        DisasterInfo(
            type: .flood,
            example: "2018 Kerala Floods",
            causes: "**Floods** are one of the most common disasters. They can happen from heavy rain, melting snow, or even a dam breaking. **Flash floods** are the most dangerous because they happen so fast, sometimes in just a few minutes.",
            contentList: [
                InfoSection(heading: "Types of Floods", points: [
                    "**Flash Floods:** Very fast-moving water that happens suddenly after heavy rain.",
                    "**River Floods:** When rivers overflow their banks from too much rain upstream.",
                    "**Coastal Floods:** When the ocean is pushed inland by storms or tsunamis."
                ], systemImage: "cloud.rain.fill"),
                InfoSection(heading: "Safety Basics", points: [
                    "**Evacuate early:** if you're told to leave, do it right away. Move to higher ground immediately.",
                    "**Turn Around, Don't Drown:** Never try to walk or drive through floodwater. Just a few inches of moving water can sweep you off your feet.",
                    "**Stay off bridges** over fast water, because they could collapse.",
                    "**Turn off power** if your house is flooding, but only if you're dry."
                ], systemImage: "figure.stand"),
                InfoSection(heading: "Staying Healthy", points: [
                    "**Avoid floodwater.** It's usually dirty and can have chemicals or sewage in it.",
                    "**Safe water:** Don't drink tap water until you're told it's okay. Use bottled water or boil yours first.",
                    "**Throw away** any food that touched the floodwater."
                ], systemImage: "drop.fill")
            ]
        ),
        
        DisasterInfo(
            type: .fire,
            example: "Australia Bushfires",
            causes: "**Home fires** usually start from cooking, bad wiring, or heaters left alone. **Wildfires** spread fast because of dry weather, wind, and heat. They can be started by lightning or by accident.",
            contentList: [
                InfoSection(heading: "Preventing Fires", points: [
                    "**Smoke alarms:** Put them in every bedroom and on every floor.",
                    "**Test them:** Check your alarms once a month and change batteries every year.",
                    "**Watch the stove:** Never leave cooking food alone."
                ], systemImage: "house.fill"),
                InfoSection(heading: "Escaping a Fire", points: [
                    "**Get out fast.** If there's a fire, leave immediately and call for help. Don't go back in for anything.",
                    "**Crawl low:** Smoke rises, so the air is cleanest near the floor.",
                    "**Check doors:** Feel the door before opening. If it's hot, use a different exit.",
                    "**Meeting spot:** Pick a spot outside where everyone knows to meet."
                ], systemImage: "arrow.uturn.right"),
                InfoSection(heading: "Using an Extinguisher (P.A.S.S.)", points: [
                    "**P - Pull** the pin.",
                    "**A - Aim** at the base of the fire.",
                    "**S - Squeeze** the lever.",
                    "**S - Sweep** side to side."
                ], systemImage: "flame")
            ]
        ),
        
        DisasterInfo(
            type: .cyclone,
            example: "Hurricane Katrina / Cyclone Amphan",
            causes: "**Cyclones** and hurricanes are huge rotating storms that form over warm ocean water. They bring really strong winds, heavy rain, and huge waves called storm surges when they hit land.",
            contentList: [
                InfoSection(heading: "Getting Ready", points: [
                    "**Windows:** Board them up with plywood or use storm shutters to protect your home.",
                    "**Loose items:** Bring in anything outside like chairs or trash cans so they don't blow away.",
                    "**Go-Bag:** Have a bag ready with a radio, water, and some food."
                ], systemImage: "hammer.fill"),
                InfoSection(heading: "During the Storm", points: [
                    "**Stay inside** and stay away from windows.",
                    "**Find a safe room:** Go to a small room in the middle of the house on the lowest floor.",
                    "**The Eye:** Don't go outside if it gets calm. That's just the 'eye' of the storm, and the wind will start again soon."
                ], systemImage: "house.and.flag.fill"),
                InfoSection(heading: "Evacuating", points: [
                    "**Leave if told:** If there's an evacuation order, go right away.",
                    "**Avoid floods:** Don't drive through flooded roads.",
                    "**Let family know:** Tell your family where you are going before you lose phone service."
                ], systemImage: "car.fill")
            ]
        ),
        
        DisasterInfo(
            type: .tsunami,
            example: "2004 Indian Ocean Tsunami",
            causes: "**Tsunamis** are giant ocean waves caused by underwater earthquakes or landslides. Most tsunamis happen because of a big earthquake deep under the sea floor.",
            contentList: [
                InfoSection(heading: "Warning Signs", points: [
                    "**Feel:** A long, strong earthquake near the coast.",
                    "**See:** The water suddenly pulling back and exposing the sea floor.",
                    "**Hear:** A loud roar from the ocean, like a train or a plane engine."
                ], systemImage: "exclamationmark.triangle.fill"),
                InfoSection(heading: "Survival Steps", points: [
                    "**Don't wait:** If you see any signs, the earthquake is your warning. Run inland right away.",
                    "**Go high:** Get to high ground at least 100 feet up or move a mile away from the shore.",
                    "**Last resort:** If you can't get away, go to the top floor of a strong concrete building.",
                    "**In the water:** Grab onto something that floats like a tree or a door."
                ], systemImage: "arrow.up.right"),
                InfoSection(heading: "After the Wave", points: [
                    "**More waves:** A tsunami is a series of waves, and the first one isn't always the biggest.",
                    "**Stay away:** Waves can keep coming for hours. Don't go back to the beach until it's safe.",
                    "**Watch for debris:** Stay away from broken buildings or power lines."
                ], systemImage: "water.waves")
            ]
        ),
        
        DisasterInfo(
            type: .heatwave,
            example: "2023 European Heatwaves",
            causes: "**Heatwaves** are long periods of really hot weather. They happen when a high-pressure system stays over an area and traps the hot air, keeping it from cooling down.",
            contentList: [
                InfoSection(heading: "Health Risks", points: [
                    "**Heat Exhaustion:** Sweating, feeling weak or faint. Move to a cool place and drink water.",
                    "**Heat Stroke:** This is an emergency. Skin is hot and dry, person is confused or passes out. Call 911 immediately."
                ], systemImage: "thermometer.sun.fill"),
                InfoSection(heading: "Staying Hydrated", points: [
                    "**Drink water:** Drink plenty of water even if you don't feel thirsty.",
                    "**Avoid sugar:** Stay away from sugary or alcoholic drinks because they can dehydrate you.",
                    "**Minerals:** Use sports drinks to replace what you lose from sweating."
                ], systemImage: "drop.triangle"),
                InfoSection(heading: "Keeping Cool", points: [
                    "**Stay inside:** Use air conditioning if you can. If not, go to a public place like a mall or library.",
                    "**Clothing:** Wear light-colored, loose clothes.",
                    "**Never leave anyone in a car:** Cars get hot incredibly fast and it can be deadly."
                ], systemImage: "fan.fill")
            ]
        ),
        
        DisasterInfo(
            type: .pandemic,
            example: "COVID-19 Pandemic",
            causes: "**Pandemics** happen when a new virus or bacteria spreads across the whole world. Because it's new, people don't have immunity to it yet, so it spreads very fast.",
            contentList: [
                InfoSection(heading: "Preventing Illness", points: [
                    "**Wash hands:** Use soap and water for 20 seconds as much as you can.",
                    "**Sanitize:** Use hand sanitizer if you can't wash your hands.",
                    "**Don't touch your face:** Keep your hands away from your eyes, nose, and mouth.",
                    "**Masks:** Wear a good mask in crowded places to stop germs."
                ], systemImage: "hands.sparkles.fill"),
                InfoSection(heading: "Staying Safe", points: [
                    "**Distancing:** Stay 6 feet away from others when out.",
                    "**Isolate:** If you feel sick, stay home and away from others.",
                    "**Vaccines:** Keep up to date with your shots to stay protected."
                ], systemImage: "person.fill.xmark"),
                InfoSection(heading: "Supplies", points: [
                    "**Stock up:** Have enough food and medicine for a few weeks if you can.",
                    "**Medicine:** Keep some basic fever or cough medicine at home."
                ], systemImage: "pill.fill")
            ]
        )
    ]
}
