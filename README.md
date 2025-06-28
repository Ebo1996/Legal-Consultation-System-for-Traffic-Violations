<h2>Legal Consultation System for Traffic Violations</h2>
<img src="https://img.shields.io/badge/Project-Type-AI%20Expert%20System-blue" alt="Project Type: AI Expert System" />
<img src="https://img.shields.io/badge/Language-Prolog-yellow" alt="Language: Prolog" />
<hr>

<p><strong>Legal Consultation System for Traffic Violations</strong> is an <em>AI-based Prolog expert system</em> that provides legal guidance related to common traffic rule violations. It evaluates offenses, calculates fines and penalty points, flags license suspension conditions, and suggests appropriate legal actions.</p>

<h3>🚦 Key Functionalities:</h3>
<ul>
  <li>Checks for common traffic violations based on predefined rules</li>
  <li>Classifies violations as <strong>minor</strong> or <strong>major</strong></li>
  <li>Calculates <strong>total fine</strong> and <strong>license points</strong></li>
  <li>Flags possible <strong>license suspension</strong></li>
  <li>Detects <strong>repeat offenses</strong> and <strong>habitual offenders</strong></li>
  <li>Handles <strong>exceptions</strong> (e.g., emergency vehicle, medical condition)</li>
  <li>Suggests <strong>legal advice</strong> and <strong>preventive measures</strong></li>
</ul>

<h3>🧠 Example Use Case:</h3>
<pre>
<strong>Query:</strong> ?- consult_legal_expert(john).

<strong>Output:</strong>
--- Legal Consultation Report ---
Violation: speeding
Location: urban
Penalty: fine(200)
Demerit Points: points(2)
Suggestion: Use cruise control in city areas
*** Repeat Offense Detected ***
Legal Consequence: License suspension possible.
Note: You may face court proceedings.
You are flagged as a habitual offender.
</pre>

<h3>📚 Rule Categories:</h3>
<ul>
  <li><strong>Traffic Rules:</strong> speed limits, seat belts, red lights, etc.</li>
  <li><strong>Zones:</strong> urban, rural, school zone, etc.</li>
  <li><strong>Vehicle Types:</strong> car, bike, emergency vehicle, etc.</li>
  <li><strong>Time-sensitive Violations:</strong> headlight at night, horn in silent zones</li>
  <li><strong>Fine Calculation:</strong> Based on each violation type</li>
  <li><strong>License Suspension:</strong> 6+ demerit points triggers warning</li>
  <li><strong>Suggestions:</strong> Safety tips based on violation</li>
</ul>

<h3>💼 Legal Advice Logic:</h3>
<ul>
  <li><code>minor_violation</code> → Advice: "Pay fine and attend driving course"</li>
  <li><code>major_violation</code> → Advice: "Consult lawyer for plea bargain"</li>
  <li><code>license_suspension</code> → Advice: "Immediate legal consultation required"</li>
</ul>

<h3>⚖️ Special Handling:</h3>
<ul>
  <li>Handles <code>exceptions</code> such as medical conditions or emergency services</li>
  <li>Identifies <code>habitual offenders</code> from past violations</li>
  <li>Issues <strong>court appearance warnings</strong> for repeat offenses</li>
</ul>

<h3>✅ Getting Started:</h3>
<pre>
1. Install SWI-Prolog from: https://www.swi-prolog.org/
2. Load the program file:
   ?- [traffic_consultation].

3. Run the consultation:
   ?- consult_legal_expert(john).
</pre>

<h3>📌 Project Info:</h3>
<ul>
  <li><strong>Type:</strong> AI Expert System</li>
  <li><strong>Language:</strong> Prolog</li>
  <li><strong>Topic:</strong> Traffic Law Advisory</li>
  <li><strong>Author:</strong> [Your Name Here]</li>
</ul>

<h3>🔒 Disclaimer:</h3>
<p>This system is developed for academic purposes only and should not be used as a substitute for real legal consultation.</p>
