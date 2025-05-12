local ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    exports.ox_target:addBoxZone({
        coords = Config.QuizLocation,
        size = vector3(1.5, 1.5, 1.0),
        options = {
            {
                name = 'start_quiz',
                label = 'Take Weapon License Quiz ($' .. Config.QuizCost .. ')',
                onSelect = function()
                    StartQuiz()
                end,
                canInteract = function(entity, distance, coords)
                    return true
                end
            }
        }
    })
end)

function StartQuiz()
    ESX.TriggerServerCallback("weaponlicense:checkExistingLicense", function(hasLicense)
        if hasLicense then
            ESX.ShowNotification("You already have a weapon license.")
            return
        end

        ESX.TriggerServerCallback("weaponlicense:checkMoney", function(hasEnoughMoney)
            if not hasEnoughMoney then
                ESX.ShowNotification("You do not have enough money to take the quiz.")
                return
            end

            local questionIndex = 1

            local function ShowQuestion()
                if questionIndex > #Config.Questions then
                    ESX.ShowNotification("Congratulations! You passed the quiz.")
                    TriggerServerEvent("weaponlicense:grantLicense")
                    return
                end

                local question = Config.Questions[questionIndex]
                local options = {}

                for i, answer in ipairs(question.answers) do
                    table.insert(options, {
                        title = answer,
                        description = "Select this answer",
                        onSelect = function()
                            if i == question.correctAnswer then
                                ESX.ShowNotification("Correct! Moving to the next question.")
                                questionIndex = questionIndex + 1
                                ShowQuestion()
                            else
                                ESX.ShowNotification("Wrong answer! Quiz failed.")
                            end
                        end
                    })
                end

                table.insert(options, {
                    title = "Exit Quiz",
                    description = "Cancel the quiz",
                    onSelect = function()
                        ESX.ShowNotification("You exited the quiz.")
                    end
                })

                exports.ox_lib:registerContext({
                    id = 'quiz_question_' .. questionIndex,
                    title = question.question,
                    options = options
                })

                exports.ox_lib:showContext('quiz_question_' .. questionIndex)
            end

            ShowQuestion()
        end)
    end)
end
