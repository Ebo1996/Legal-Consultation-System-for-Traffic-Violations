/*
  Legal Consultation System for Traffic Violations
  AI PROJECT - Prolog-Based Expert System
*/

% ---------------------------- %
%        KNOWLEDGE BASE       %
% ---------------------------- %

% Traffic Rules
rule(speed_limit, 'Do not exceed 60km/h in urban areas').
rule(seat_belt, 'Seat belt must be worn at all times').
rule(no_phone, 'Using a mobile phone while driving is prohibited').
rule(red_light, 'Do not cross red traffic lights').
rule(drunk_driving, 'Driving under influence of alcohol is strictly prohibited').
rule(helmet_rule, 'Motorcyclists must wear helmets').
rule(no_parking_zone, 'Do not park in restricted areas').
rule(valid_license, 'A valid driving license must be carried while driving').
rule(zebra_crossing, 'Stop for pedestrians at zebra crossings').

% Vehicles
vehicle_type(car).
vehicle_type(bike).
vehicle_type(bus).
vehicle_type(truck).
vehicle_type(emergency_vehicle).
vehicle_type(auto_rickshaw).

% Road Zones
zone(urban).
zone(highway).
zone(school_zone).
zone(rural).
zone(market_area).

% Weather Conditions
weather(clear).
weather(rainy).
weather(foggy).
weather(snowy).

% Time of Day
timeofday(day).
timeofday(night).

time_sensitive_violation(no_headlight).
time_sensitive_violation(horn_in_silent_zone).

% Violations
violation(speeding).
violation(seat_belt_off).
violation(phone_usage).
violation(red_light_cross).
violation(drunk_driving).
violation(no_helmet).
violation(red_light_run).
violation(illegal_parking).
violation(dui).
violation(no_license).
violation(no_headlight).
violation(horn_in_silent_zone).
violation(zebra_crossing_violation).

% Severity levels
minor_violation(speeding).
minor_violation(illegal_parking).
minor_violation(horn_in_silent_zone).
minor_violation(no_headlight).
major_violation(red_light_run).
major_violation(dui).
major_violation(no_license).
major_violation(drunk_driving).
major_violation(zebra_crossing_violation).

% Fine amounts (in dollars)
fine(speeding, 150).
fine(red_light_run, 300).
fine(illegal_parking, 75).
fine(dui, 1000).
fine(no_license, 500).
fine(no_headlight, 100).
fine(horn_in_silent_zone, 50).
fine(zebra_crossing_violation, 250).

% License points
points(speeding, 2).
points(red_light_run, 4).
points(illegal_parking, 0).
points(dui, 8).
points(no_license, 6).
points(no_headlight, 1).
points(horn_in_silent_zone, 1).
points(zebra_crossing_violation, 5).

% License Suspension Rule
license_suspension(Violation) :-
    points(Violation, Points),
    Points >= 6.

% Calculate total fine for multiple violations
total_fine([], 0).
total_fine([Violation|Rest], Total) :-
    fine(Violation, Amount),
    total_fine(Rest, RestTotal),
    Total is Amount + RestTotal.

% Check if court appearance is needed
court_required(Violation) :-
    major_violation(Violation).

% Legal advice generator
legal_advice(Violation, 'Pay fine and attend driving course') :-
    minor_violation(Violation).
legal_advice(Violation, 'Consult lawyer for plea bargain') :-
    major_violation(Violation),
    \+ license_suspension(Violation).
legal_advice(Violation, 'Immediate legal consultation required') :-
    license_suspension(Violation).

% Main consultation predicate
consultation(Violations, Advice, TotalFine, Suspension) :-
    validate_violations(Violations),
    total_fine(Violations, TotalFine),
    ( member(V, Violations), license_suspension(V) ->
        (Advice = 'Immediate legal consultation required', Suspension = yes)
    ; member(V, Violations), major_violation(V) ->
        (Advice = 'Consult lawyer for plea bargain', Suspension = no)
    ; (Advice = 'Pay fine and attend driving course', Suspension = no)
    ).

% Helper to validate input violations
validate_violations([]).
validate_violations([V|Rest]) :-
    violation(V),
    validate_violations(Rest).

% Offense Records
offense(john, speeding, 75, urban).
offense(alice, seat_belt_off, 0, highway).
offense(bob, phone_usage, 0, urban).
offense(claire, red_light_cross, 0, school_zone).
offense(david, drunk_driving, 0, urban).
offense(emily, no_helmet, 0, rural).
offense(kevin, zebra_crossing_violation, 0, market_area).
offense(ron, horn_in_silent_zone, 0, school_zone).
offense(sara, no_headlight, 0, highway).

% Repeated Offenses
repeat_offense(john, speeding, 3).
repeat_offense(david, drunk_driving, 2).
repeat_offense(sara, no_headlight, 2).

% Exceptions
exception(speeding, emergency_vehicle).
exception(seat_belt_off, medical_condition).
exception(horn_in_silent_zone, ambulance_siren).
has_exception(emily, no_helmet).

% Penalty Rules
penalty(speeding, fine(200), points(2)).
penalty(seat_belt_off, fine(100), points(1)).
penalty(phone_usage, fine(300), points(3)).
penalty(red_light_cross, fine(500), points(4)).
penalty(drunk_driving, fine(1000), points(6)).
penalty(no_helmet, fine(150), points(2)).
penalty(no_license, fine(500), points(6)).
penalty(zebra_crossing_violation, fine(250), points(5)).

% Extra Penalty for Repeats
extra_penalty(X) :- repeat_offense(X, _, N), N >= 2.

% Suggestions
suggest_action(speeding, 'Use cruise control in city areas').
suggest_action(seat_belt_off, 'Always wear seat belt for safety').
suggest_action(phone_usage, 'Use hands-free devices or avoid calls').
suggest_action(red_light_cross, 'Wait for green signal to avoid accidents').
suggest_action(drunk_driving, 'Avoid drinking before driving or use a cab').
suggest_action(no_helmet, 'Always wear helmet for protection').
suggest_action(no_headlight, 'Check vehicle lights before night driving').
suggest_action(horn_in_silent_zone, 'Avoid honking in silent areas').
suggest_action(zebra_crossing_violation, 'Always yield to pedestrians').

% Check for Legal Exceptions
is_exception(Person, Violation) :- has_exception(Person, Violation).

% Suggestion Engine
give_suggestion(Violation) :-
    suggest_action(Violation, Suggestion),
    write('Suggestion: '), write(Suggestion), nl.

% Combined Legal Advice Engine
legal_advice(Person) :-
    offense(Person, Violation, _, Zone),
    ( is_exception(Person, Violation) ->
        write('No Penalty. Legal Exception Granted.'), nl
    ; penalty(Violation, Fine, Points),
      write('Violation: '), write(Violation), nl,
      write('Location: '), write(Zone), nl,
      write('Penalty: '), write(Fine), nl,
      write('Demerit Points: '), write(Points), nl,
      give_suggestion(Violation)
    ),
    (extra_penalty(Person) ->
        write('*** Repeat Offense Detected ***'), nl,
        write('Legal Consequence: License suspension possible.'), nl ; true).

% Recursive Offense Evaluation
previous_violation(john, phone_usage).
previous_violation(john, speeding).

is_habitual_offender(Person) :-
    findall(V, previous_violation(Person, V), List),
    length(List, Count),
    Count >= 2.

% Consultation Interface
consult_legal_expert(Person) :-
    write('--- Legal Consultation Report ---'), nl,
    legal_advice(Person),
    (extra_penalty(Person) -> write('Note: You may face court proceedings.'), nl ; true),
    (is_habitual_offender(Person) -> write('You are flagged as a habitual offender.'), nl ; true).

% ---------------------------- %
%         END OF FILE         %
% ---------------------------- %
