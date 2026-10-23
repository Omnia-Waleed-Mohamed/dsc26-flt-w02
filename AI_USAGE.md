# AI usage: dsc26-flt-w02

AI tools are allowed in this task. Fill in every section in your own words. Short is fine; honest is required. This file is read by your Track Mentor, not by the grader.

## 1. Tools I used

ChatGPT and Gemini in the browser to assist with the model JSON parsing logic, Arabic text normalisation rules, and structuring the UI layout.

## 2. The two or three most useful prompts

1. How to write a robust JSON parser in Dart that throws FormatException instead of TypeError for invalid types.
2. What are the correct Arabic text normalisation rules for search matching (handling Alif variations, Ha/Ta marbuta, Ya, tatweel, and diacritics).
3. How to structure a clean Flutter UI screen with ViewModels using the required Keys for widget testing.

## 3. One thing the AI got wrong or left out, and how I found it

The AI initially suggested putting the sorting and filtering logic directly inside the UI widgets. I found that this violated the architectural layering constraints by reading the task requirements and architecture rules in the README.

## 4. Why `visibleAlerts` lives in the view model and not in the screen

Placing `visibleAlerts` in the view model keeps the business logic, sorting, and filtering fully testable independently of the UI widget tree. It ensures the UI remains a pure reflection of the state without performing complex data manipulations during rendering.