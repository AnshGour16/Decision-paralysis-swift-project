import SwiftUI

struct SimulatorQuestion: Identifiable {
    let id = UUID()
    let disasterType: DisasterType
    let scenario: String
    let options: [String]
    let correctAnswerIndex: Int
    let explanation: String
}

class SimulatorViewModel: ObservableObject {
    private let allQuestions: [SimulatorQuestion] = [
        SimulatorQuestion(
            disasterType: .earthquake,
            scenario: "You are inside a shopping mall when a large earthquake begins. What is the safest immediate action?",
            options: ["Run for the exit as fast as possible", "Drop, Cover, and Hold On under a sturdy table or desk", "Stand near a large glass window to see outside", "Take the elevator to get to the ground floor"],
            correctAnswerIndex: 1,
            explanation: "Drop, Cover, and Hold On is the best thing to do. Running is risky because things might fall on you, and elevators can get stuck if the power goes out."
        ),
        SimulatorQuestion(
            disasterType: .earthquake,
            scenario: "You are driving your car when you feel a strong earthquake. How should you respond?",
            options: ["Speed up to get home quickly", "Stop the car under a bridge for protection", "Pull over to a clear area and stay inside the car", "Get out of the car and run to an open field"],
            correctAnswerIndex: 2,
            explanation: "Pull over to an open area away from bridges or power lines, and stay in your car until the shaking is over."
        ),
        SimulatorQuestion(
            disasterType: .earthquake,
            scenario: "You are outdoors walking in a city when the ground starts shaking. What is your quickest survival move?",
            options: ["Run inside the nearest tall building", "Move to an open area away from buildings, streetlights, and utility wires", "Stand directly under a balcony for shelter", "Hide under a parked car"],
            correctAnswerIndex: 1,
            explanation: "The biggest danger outside is glass or bricks falling from buildings. Try to find an open space."
        ),
        SimulatorQuestion(
            disasterType: .earthquake,
            scenario: "You are in your kitchen and smell rotten eggs after a major earthquake. What does this mean and what should you do?",
            options: ["It is just sewer gas; ignore it", "It is a sulfur deposit; open a window", "It is a natural gas leak; leave the house immediately and don't use any switches", "The food in your fridge has spoiled; throw it away"],
            correctAnswerIndex: 2,
            explanation: "That smell usually means a gas leak. Get out fast and don't touch any light switches, because even a small spark could cause an explosion."
        ),
        SimulatorQuestion(
            disasterType: .earthquake,
            scenario: "You are in bed at night and suddenly the house shakes violently. What should you do?",
            options: ["Run to the doorway", "Crawl under the bed", "Stay in bed, turn facedown, and cover your head with a pillow", "Run to the kitchen for a flashlight"],
            correctAnswerIndex: 2,
            explanation: "Staying in bed and covering your head with a pillow is actually safer than trying to run while everything is shaking."
        ),
        SimulatorQuestion(
            disasterType: .earthquake,
            scenario: "You live near the coast and feel a very strong earthquake that lasts for more than 20 seconds. What is your next move?",
            options: ["Wait for an official government SMS alert", "Turn on the TV to check the news", "Immediately move inland or to high ground", "Check the beach for receding water"],
            correctAnswerIndex: 2,
            explanation: "If you're near the ocean, a big quake is your warning that a tsunami might be coming. Don't wait—just get to high ground."
        ),
        SimulatorQuestion(
            disasterType: .earthquake,
            scenario: "What should you check FIRST after a massive earthquake ends?",
            options: ["Check yourself and others for injuries", "Check your social media for updates", "Check if your car still starts", "Check if the internet is working"],
            correctAnswerIndex: 0,
            explanation: "Safety first! Check yourself and the people around you for injuries before worrying about anything else."
        ),
        SimulatorQuestion(
            disasterType: .fire,
            scenario: "You are in a room filled with smoke from a fire. How should you breathe and move?",
            options: ["Stay as low as possible on the floor and cover your nose with a damp cloth", "Stand tall to reach the vents", "Run as fast as you can through the smoke", "Hide in a closet until help arrives"],
            correctAnswerIndex: 0,
            explanation: "Smoke and heat rise, so the air is usually clearer near the floor. Stay low and get out."
        ),
        SimulatorQuestion(
            disasterType: .fire,
            scenario: "You are trying to escape a house fire but the closed door handle feels extremely hot. What is the correct choice?",
            options: ["Kick the door open and run through", "Keep the door closed and use a different exit or a window", "Wrap your hand in a shirt and open it anyway", "Wait by the door for a few minutes for it to cool down"],
            correctAnswerIndex: 1,
            explanation: "If the handle is hot, the fire is probably right on the other side. Keep it closed and find another way out."
        ),
        SimulatorQuestion(
            disasterType: .fire,
            scenario: "Your clothes catch fire while you are escaping. What is the immediate survival rule?",
            options: ["Run to the nearest sink for water", "Stop, Drop, and Roll", "Take off the clothes immediately", "Fan the flames with your hands"],
            correctAnswerIndex: 1,
            explanation: "Running makes the fire worse because it gives it more oxygen. Stop, drop to the ground, and roll around to put it out."
        ),
        SimulatorQuestion(
            disasterType: .fire,
            scenario: "A grease fire starts in a pan on your kitchen stove. How do you extinguish it?",
            options: ["Throw water on it immediately", "Slide a metal lid over the pan and turn off the heat", "Use a wet towel to swat it out", "Blow on it until it goes out"],
            correctAnswerIndex: 1,
            explanation: "Never use water on a grease fire! It will splash and make the fire spread. Just cover the pan with a lid to choke the fire."
        ),
        SimulatorQuestion(
            disasterType: .fire,
            scenario: "You see a wildfire approaching your home from a distance. Should you wait until you see flames to leave?",
            options: ["Yes, to protect your belongings until the last second", "No, evacuate immediately when told, as wildfires move faster than you expect", "Stay and spray your roof with a garden hose", "Go into the basement to hide"],
            correctAnswerIndex: 1,
            explanation: "Wildfires move way faster than people think. If you're told to evacuate, go right away—don't wait until it's too late."
        ),
        SimulatorQuestion(
            disasterType: .fire,
            scenario: "To properly use a fire extinguisher, what acronym should you remember?",
            options: ["PASS (Pull, Aim, Squeeze, Sweep)", "FAST (Fire, Aim, Stop, Stay)", "STOP (Stop, Turn, Open, Push)", "SAFE (Secure, Aim, Fire, Exit)"],
            correctAnswerIndex: 0,
            explanation: "PASS is easy to remember: Pull the pin, Aim at the base of the fire, Squeeze the lever, and Sweep side to side."
        ),
        SimulatorQuestion(
            disasterType: .flood,
            scenario: "You are driving and come across a road covered by moving water. What should you do?",
            options: ["Drive through it if it looks shallow", "Turn around and find another way", "Walk through first to test the depth", "Follow the car in front of you"],
            correctAnswerIndex: 1,
            explanation: "Turn around! You can't always tell how deep the water is, and it only takes a little bit of rushing water to wash a car away."
        ),
        SimulatorQuestion(
            disasterType: .flood,
            scenario: "Heavy rains have triggered a sudden Flash Flood Warning for your exact location. You are in a valley.",
            options: ["Immediately move to higher ground", "Stay where you are and wait for rescue", "Move to the basement for safety", "Pack a heavy suitcase before leaving"],
            correctAnswerIndex: 0,
            explanation: "Flash floods happen incredibly fast. Get to high ground immediately. Basements are dangerous because they can fill with water quickly."
        ),
        SimulatorQuestion(
            disasterType: .flood,
            scenario: "Your town is heavily flooded. You are thirsty but the tap water is coming out slightly cloudy.",
            options: ["Drink it anyway; cloudiness is just air", "Only drink bottled or properly boiled water", "Filter it through a coffee filter and drink it", "Mix it with juice to hide the taste"],
            correctAnswerIndex: 1,
            explanation: "Floodwater can ruin the drinking water supply. Stick to bottled water or boil yours until you're told the tap water is safe."
        ),
        SimulatorQuestion(
            disasterType: .flood,
            scenario: "You are trapped in a building surrounded by rising floodwaters. What is the safest place to go?",
            options: ["The basement", "An interior room on the ground floor", "The highest floor possible (but not a locked attic)", "Outside to swim to safety"],
            correctAnswerIndex: 2,
            explanation: "Go to the highest floor. Avoid small attics where you could get trapped by the rising water."
        ),
        SimulatorQuestion(
            disasterType: .flood,
            scenario: "Rising water is entering your home. What should you take with you to an upper floor?",
            options: ["An axe or heavy tool", "Your TV", "Extra blankets for the floor", "A large heavy chair"],
            correctAnswerIndex: 0,
            explanation: "If you have to go into your attic, take an axe. It sounds extreme, but you might need it to cut your way out if the water keeps rising."
        ),
        SimulatorQuestion(
            disasterType: .flood,
            scenario: "After a flood, you check your home. When is it safe to turn the electricity back on?",
            options: ["As soon as you walk inside", "If the walls look dry", "Only after a professional electrician or inspector says it's safe", "When the streetlights come back on"],
            correctAnswerIndex: 2,
            explanation: "Don't touch the power until a pro checks it out. Water and electricity are a dangerous mix, and there could be hidden damage."
        ),
        SimulatorQuestion(
            disasterType: .tsunami,
            scenario: "You are at the beach and notice the ocean suddenly receding very far, exposing the seafloor and fish. What do you do?",
            options: ["Walk out to see the exposed reef", "Take photos for social media", "Run to high ground or inland immediately", "Wait to hear a siren"],
            correctAnswerIndex: 2,
            explanation: "If the water pulls back like that, a tsunami is likely about to hit. Don't waste time—get to high ground right now."
        ),
        SimulatorQuestion(
            disasterType: .tsunami,
            scenario: "The first large tsunami wave has hit and retreated. It seems calm now.",
            options: ["Go back to the beach to help others", "Go home to check on pets", "Stay on high ground; more and larger waves may follow for hours", "Start cleaning up the debris"],
            correctAnswerIndex: 2,
            explanation: "Tsunamis come in a series of waves. The first one isn't always the biggest, so stay on high ground until everything is clearly safe."
        ),
        SimulatorQuestion(
            disasterType: .tsunami,
            scenario: "You are on a boat far out at sea when a Tsunami Warning is issued for the coast. What is the safest action?",
            options: ["Race back to the harbor as fast as possible", "Jump in the water to swim", "Stay in deep water (over 100 feet/30m deep)", "Anchor the boat near the shore"],
            correctAnswerIndex: 2,
            explanation: "Tsunamis are small in deep water. They only become big and dangerous as they reach the shallow water near the shore. Stay out at sea."
        ),
        SimulatorQuestion(
            disasterType: .tsunami,
            scenario: "A massive tsunami is directly approaching and you have no time to reach high ground. What is your completely last resort?",
            options: ["Climb to the upper floors or roof of a sturdy reinforced concrete building", "Hide behind a large tree", "Run as fast as you can parallel to the beach", "Hide in a car"],
            correctAnswerIndex: 0,
            explanation: "If you can't reach high ground, climb as high as you can in a very strong, concrete building. It's your best chance if the water hits."
        ),
        SimulatorQuestion(
            disasterType: .tsunami,
            scenario: "Which of these is NOT an effective way to protect yourself from a tsunami?",
            options: ["Moving 100 feet above sea level", "Moving 2 miles inland", "Hiding in the basement of your beach house", "Climbing to the 5th floor of a steel-frame hotel"],
            correctAnswerIndex: 2,
            explanation: "Never hide in a basement during a flood or tsunami—it's the first place that fills with water."
        ),
        SimulatorQuestion(
            disasterType: .cyclone,
            scenario: "A Category 4 hurricane is projected to hit your city. Authorities issue a mandatory evacuation order.",
            options: ["Board up the windows and stay inside", "Evacuate immediately as instructed", "Go to the basement with a week's worth of food", "Drive to the beach to watch the waves"],
            correctAnswerIndex: 1,
            explanation: "If you're told to evacuate, you should go. Surges of water from the ocean can be deadly and can trap you in your home."
        ),
        SimulatorQuestion(
            disasterType: .cyclone,
            scenario: "During a cyclone, the wind suddenly stops and the sky becomes clear and calm. Is it safe to go outside?",
            options: ["Yes, the storm is over", "No, you are likely in the 'Eye' of the storm and extreme winds will return soon", "Yes, go out to clear the storm drains", "No, because it might rain again soon"],
            correctAnswerIndex: 1,
            explanation: "You're probably just in the 'eye' of the storm. It's calm for a bit, but the other side of the storm will hit soon with very strong winds. Stay inside!"
        ),
        SimulatorQuestion(
            disasterType: .cyclone,
            scenario: "Where is the safest place to stay inside your home during a hurricane's peak winds?",
            options: ["An interior room on the lowest floor, away from windows", "Next to a large glass door to monitor the wind", "In the attic", "On the balcony"],
            correctAnswerIndex: 0,
            explanation: "Stay away from windows and glass. A small room in the middle of your house, like a closet or bathroom, is the safest spot."
        ),
        SimulatorQuestion(
            disasterType: .cyclone,
            scenario: "You have boarded up your windows for a cyclone. Should you leave one window slightly open to 'equalize pressure'?",
            options: ["Yes, it prevents the roof from blowing off", "No, this is a myth; it actually lets wind inside which can lift the roof", "Yes, but only the window facing the wind", "Only if you have a basement"],
            correctAnswerIndex: 1,
            explanation: "That's a myth. Keeping everything sealed is better. If wind gets inside, it can actually push the roof up and off."
        ),
        SimulatorQuestion(
            disasterType: .cyclone,
            scenario: "Your area is under a Hurricane WATCH. What does this mean?",
            options: ["A hurricane is currently hitting your area", "Hurricane conditions are possible within 48 hours", "The hurricane has dissipated", "You must evacuate within 1 hour"],
            correctAnswerIndex: 1,
            explanation: "A 'Watch' means a hurricane could happen soon. A 'Warning' means it's definitely coming. Use the extra time to finish your preparations."
        ),
        SimulatorQuestion(
            disasterType: .cyclone,
            scenario: "The hurricane has passed. When is it safest to go outside?",
            options: ["As soon as it stops raining", "As soon as you don't hear wind", "When local authorities give an official clear", "When the sun comes out"],
            correctAnswerIndex: 2,
            explanation: "Wait for the official word. There could be downed power lines or gas leaks that make it dangerous to be outside."
        ),
        SimulatorQuestion(
            disasterType: .heatwave,
            scenario: "You are experiencing a record-breaking heatwave. How should you adjust your hydration?",
            options: ["Drink only when you feel thirsty", "Drink plenty of water even if you don't feel thirsty", "Drink mainly caffeinated sodas and coffee", "Drink as little as possible to avoid sweating"],
            correctAnswerIndex: 1,
            explanation: "Drink water constantly. If you wait until you're thirsty, you're already starting to get dehydrated."
        ),
        SimulatorQuestion(
            disasterType: .heatwave,
            scenario: "Someone you are with develops hot, red, dry skin and becomes confused during a heatwave. What is the priority?",
            options: ["Give them a heavy meal", "This is heatstroke; call emergency services and cool them down immediately", "Tell them to take a nap in the sun", "Give them a hot cup of tea"],
            correctAnswerIndex: 1,
            explanation: "That sounds like heatstroke. It's serious, so call for help and try to cool them down right away."
        ),
        SimulatorQuestion(
            disasterType: .heatwave,
            scenario: "What should you eat during a severe heatwave to stay cool?",
            options: ["Hot, spicy soups", "Heavy, protein-rich meals like steak", "Small, light, cold meals like fruit and salad", "Nothing at all"],
            correctAnswerIndex: 2,
            explanation: "Large, heavy meals make your body work harder and get hotter. Stick to light, cold snacks like fruit or salad."
        ),
        SimulatorQuestion(
            disasterType: .heatwave,
            scenario: "You don't have air conditioning during a heatwave. Which strategy is most effective?",
            options: ["Cover windows that receive morning or afternoon sun", "Keep all windows open at noon", "Wear dark, heavy clothing", "Stay on the top floor of the building"],
            correctAnswerIndex: 0,
            explanation: "Keep the sun out! Using curtains or blocking the windows will keep the house much cooler."
        ),
        SimulatorQuestion(
            disasterType: .heatwave,
            scenario: "Which group of people is MOST at risk during a heatwave?",
            options: ["Adults aged 20-40", "Teenagers", "Young children, the elderly, and people with chronic illnesses", "Athletes"],
            correctAnswerIndex: 2,
            explanation: "Kids and the elderly have a harder time cooling their bodies down, so they're at much higher risk."
        ),
        SimulatorQuestion(
            disasterType: .pandemic,
            scenario: "During a respiratory virus pandemic, what is the single most effective way to prevent the spread of germs?",
            options: ["Wearing a hat", "Frequent handwashing with soap for at least 20 seconds", "Avoid eating vegetables", "Drinking hot water twice a day"],
            correctAnswerIndex: 1,
            explanation: "Washing your hands well is the best way to get rid of germs before you touch your face or someone else."
        ),
        SimulatorQuestion(
            disasterType: .pandemic,
            scenario: "You feel sick with symptoms of a contagious virus during a pandemic. What should you do?",
            options: ["Go to a crowded shopping mall", "Stay home and isolate from others until you are no longer contagious", "Visit all your relatives to say goodbye", "Continue going to work as normal"],
            correctAnswerIndex: 1,
            explanation: "Stay home! It stops the virus from spreading to more people and helps keep everyone safe."
        ),
        SimulatorQuestion(
            disasterType: .pandemic,
            scenario: "How should you cover your mouth when you cough or sneeze during a pandemic?",
            options: ["Into your bare hands", "Into the air away from people", "Into a tissue or your inner elbow", "Don't cover it at all"],
            correctAnswerIndex: 2,
            explanation: "Use a tissue or your elbow. If you use your hands, you might spread germs to everything you touch."
        ),
        SimulatorQuestion(
            disasterType: .pandemic,
            scenario: "What does 'Social Distancing' (or Physical Distancing) mean?",
            options: ["Staying at home 24/7 without exception", "Stopping all communication with friends", "Maintaining at least 6 feet (2m) of space between yourself and others in public", "Avoiding social media"],
            correctAnswerIndex: 2,
            explanation: "It just means keeping some space between you and other people in public so you don't breathe in their germs."
        ),
        SimulatorQuestion(
            disasterType: .pandemic,
            scenario: "Why shouldn't you touch your eyes, nose, or mouth during a pandemic?",
            options: ["It will cause a rash", "Viruses enter your body through those mucous membranes after your hands touch a contaminated surface", "It will make you look tired", "It is considered rude"],
            correctAnswerIndex: 1,
            explanation: "If you touch something with germs on it and then touch your face, you're basically giving the virus a direct path into your body."
        )
    ]
    
    @Published var questions: [SimulatorQuestion] = []
    @Published var currentIndex = 0
    @Published var score = 0
    @Published var selectedAnswer: Int? = nil
    @Published var showExplanation = false
    @Published var isGameOver = false
    
    var currentQuestion: SimulatorQuestion {
        if questions.isEmpty {
            return allQuestions[0]
        }
        return questions[currentIndex]
    }
    
    init() {
        restartGame()
    }
    
    func restartGame() {
        questions = Array(allQuestions.shuffled().prefix(10))
        currentIndex = 0
        score = 0
        selectedAnswer = nil
        showExplanation = false
        isGameOver = false
    }
    
    func selectAnswer(_ index: Int) {
        guard selectedAnswer == nil else { return }
        
        selectedAnswer = index
        let isCorrect = (index == currentQuestion.correctAnswerIndex)
        
        if isCorrect {
            score += 1
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
        
        withAnimation {
            showExplanation = true
        }
    }
    
    func nextQuestion() {
        if currentIndex < questions.count - 1 {
            withAnimation {
                currentIndex += 1
                selectedAnswer = nil
                showExplanation = false
            }
        } else {
            withAnimation {
                isGameOver = true
            }
        }
    }
}

