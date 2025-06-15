% ----------------------------
% Ethiopian Nutrition & Diet Planning Expert System (with Age & Gender)
% ----------------------------

% ---------- Food Facts ----------
% food(Name, Calories, Protein, Carbs, Fat, Category).
food(injera, 200, 4, 40, 1, carb).
food(shiro, 150, 10, 20, 5, protein).
food(doro_wot, 250, 30, 10, 15, protein).
food(tibs, 300, 25, 5, 20, protein).
food(kitfo, 350, 30, 0, 30, protein).
food(misir_wot, 180, 12, 22, 6, protein).
food(teff_bread, 220, 7, 35, 3, carb).
food(kale, 50, 3, 8, 1, vegetable).
food(avocado, 160, 2, 8, 15, fat).
food(kinche, 180, 5, 30, 4, carb).
food(genfo, 210, 6, 35, 2, carb).

% ---------- Health Conditions ----------
health_condition(diabetic, sugar).
health_condition(hypertension, fat).
health_condition(kidney_disease, protein).

% ---------- Goals ----------
goal(weight_loss, low_calorie).
goal(muscle_gain, high_protein).
goal(maintain_weight, balanced).

% ---------- Age Groups ----------
age_group(0, 12, child).
age_group(13, 59, adult).
age_group(60, 120, senior).

% ---------- Calorie Limits Based on Age for Weight Loss ----------
calorie_limit(weight_loss, child, 150).
calorie_limit(weight_loss, adult, 200).
calorie_limit(weight_loss, senior, 180).

% ---------- Protein Requirements Based on Gender for Muscle Gain ----------
protein_requirement(muscle_gain, male, 25).
protein_requirement(muscle_gain, female, 20).

% ---------- Fat Limits Based on Age for Hypertension ----------
fat_limit(hypertension, child, 4).
fat_limit(hypertension, adult, 5).
fat_limit(hypertension, senior, 3).

% ---------- Protein Limits Based on Age for Kidney Disease ----------
protein_limit(kidney_disease, child, 8).
protein_limit(kidney_disease, adult, 10).
protein_limit(kidney_disease, senior, 7).

% ---------- Interactive Start ----------
start :-
    writeln('🟢 Welcome to the Ethiopian Nutrition & Diet Planner!'),
    writeln('Please enter your age in years:'),
    read(Age),
    age_groupify(Age, AgeGroup),
    writeln('What is your gender? (male / female)'),
    read(Gender),
    writeln('What is your health goal? (weight_loss / muscle_gain / maintain_weight)'),
    read(Goal),
    writeln('Do you have a health condition? (diabetic / hypertension / kidney_disease / none)'),
    read(Condition),
    nl,
    format('Your age group is ~w and gender is ~w.~n', [AgeGroup, Gender]),
    writeln('🍽️ Recommended Foods for You:'),
    (
        Condition == none ->
            list_foods(Goal, AgeGroup, Gender)
        ;
            list_foods(Goal, Condition, AgeGroup, Gender)
    ),
    writeln('✅ Eat well and stay healthy!').

% ---------- Age group identification ----------
age_groupify(Age, Group) :-
    age_group(Low, High, Group),
    Age >= Low,
    Age =< High.

% ---------- Suggest foods based on goal, condition, age, and gender ----------
suggest_food(Goal, Condition, AgeGroup, Gender, Food) :-
    suggest_food_based_on_goal(Goal, AgeGroup, Gender, Food),
    suggest_food_based_on_condition(Condition, AgeGroup, Food).

suggest_food(Goal, AgeGroup, Gender, Food) :-
    suggest_food_based_on_goal(Goal, AgeGroup, Gender, Food).

% ---------- Suggestion rules for Goals ----------
suggest_food_based_on_goal(weight_loss, AgeGroup, _, Food) :-
    calorie_limit(weight_loss, AgeGroup, Limit),
    food(Food, Calories, _, _, _, _),
    Calories =< Limit.

suggest_food_based_on_goal(muscle_gain, _, Gender, Food) :-
    protein_requirement(muscle_gain, Gender, MinProtein),
    food(Food, _, Protein, _, _, _),
    Protein >= MinProtein.

suggest_food_based_on_goal(maintain_weight, _, _, Food) :-
    food(Food, Calories, _, _, _, _),
    Calories =< 250.

% ---------- Suggestion rules for Health Conditions ----------
suggest_food_based_on_condition(diabetic, _, Food) :-
    food(Food, _, _, Carbs, _, _),
    Carbs =< 20.

suggest_food_based_on_condition(hypertension, AgeGroup, Food) :-
    fat_limit(hypertension, AgeGroup, MaxFat),
    food(Food, _, _, _, Fat, _),
    Fat =< MaxFat.

suggest_food_based_on_condition(kidney_disease, AgeGroup, Food) :-
    protein_limit(kidney_disease, AgeGroup, MaxProtein),
    food(Food, _, Protein, _, _, _),
    Protein =< MaxProtein.

% ---------- List foods when user has condition ----------
list_foods(Goal, Condition, AgeGroup, Gender) :-
    suggest_food(Goal, Condition, AgeGroup, Gender, Food),
    format('- ~w~n', [Food]),
    fail.
list_foods(_, _, _, _).

% ---------- List foods when user has no condition ----------
list_foods(Goal, AgeGroup, Gender) :-
    suggest_food(Goal, AgeGroup, Gender, Food),
    format('- ~w~n', [Food]),
    fail.
list_foods(_, _, _).
