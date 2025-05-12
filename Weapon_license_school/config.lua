Config = {}

Config.QuizLocation = vector3(12.32, -1106.17, 29.90) -- Default location for the quiz
Config.QuizCost = 2800 -- Cost to take the quiz
Config.Questions = {
    {
        question = "What is the legal age to own a firearm?",
        answers = {"18", "21", "25", "30"},
        correctAnswer = 2
    },
    {
        question = "What should you do before firing a weapon?",
        answers = {"Load it", "Aim", "Ensure the area is safe", "Check the weather"},
        correctAnswer = 3
    },
    {
        question = "Is it legal to brandish a weapon in public?",
        answers = {"No, it's illegal", "Yes, if you own it", "Only in emergencies", "Depends on the time of day"},
        correctAnswer = 1
    },
    {
        question = "How often should you clean your firearm?",
        answers = {"Daily", "Monthly", "Never", "After every use"},
        correctAnswer = 4
    },
    {
        question = "Can you lend your firearm to a friend without a license?",
        answers = {"Yes, if they're trustworthy", "No, it's illegal", "Only for emergencies", "Depends on the state"},
        correctAnswer = 2
    },
    {
        question = "What should you do if your firearm is stolen?",
        answers = {"Report it to the police immediately", "Ignore it", "Wait a week", "Buy a new one"},
        correctAnswer = 1
    },
    {
        question = "Where should you store your firearm at home?",
        answers = {"Under your pillow", "On the table", "In a locked safe", "In your car"},
        correctAnswer = 3
    },
    {
        question = "What is the primary safety rule when handling a firearm?",
        answers = {
            "Keep your finger on the trigger",
            "Load it before storing",
            "Wave it around to show it's empty",
            "Point it in a safe direction"
        },
        correctAnswer = 4
    }
}
