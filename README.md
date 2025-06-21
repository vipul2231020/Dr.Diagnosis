Dr. Diagnosis is a cross-platform mobile app built using Flutter, powered by a Spring Boot backend API and enhanced with Machine Learning (NLP) for medical assistance. It allows users to analyze symptoms, consult an AI doctor chatbot, and make better health decisions.

📱 Features

🔐 User Authentication (Login, Signup, Profile)

🧠 Symptom Checker – Predict possible diseases using ML

🗣️ AI Chatbot – Interact with an NLP-based virtual health assistant

🧾 Health History Tracking

🔍 Medicine Search

🖼️ Image-based Diagnosis (Upcoming)

📦 Fully integrated with a secure Spring Boot REST API

🛠️ Tech Stack

🎯 Frontend (Flutter)
Dart & Flutter SDK

Flutter Secure Storage

Custom Navigation & Animations

State Management (Provider / setState)

HTTP Client for API interaction

🧩 Backend (Spring Boot)

Spring Security (JWT-based auth)

RESTful APIs

Role-based Access Control

H2/PostgreSQL (configurable)

Swagger Documentation (optional)

🤖 Machine Learning

Natural Language Processing (NLP) model integrated via API

Trained using medical symptom datasets

FastText / spaCy / custom model deployed as a service

( Direct download Available - https://drive.google.com/file/d/1q1kMlP149uoldvnS4IueqOHUoHYptHZQ/view?usp=drive_link )

🔧 Getting Started

1. Clone the Project
   bash
   Copy
   Edit
   git clone https://github.com/vipul2231020/Dr.Diagnosis.git
   cd dr-diagnosis-app
   (you can also clone backend with https://github.com/Shashankcode9/Dr.Diagnosis_Authentication_API.git)

2. Run Flutter App
   bash
   Copy
   Edit
   flutter pub get
   flutter run

3. Run Backend API
   bash
   Copy
   Edit
   cd backend
   ./mvnw spring-boot:run


📁 Project Structure
bash
Copy
Edit
/lib
/screens
/common_files
main.dart

/backend
/src/main/java
/resources
pom.xml

🔐 API & Authentication


JWT tokens for secure requests

Email verification & OTP

Role-based protection for sensitive endpoints

Integration with Flutter using flutter_secure_storage

🧪 Machine Learning Pipeline

Input: Symptoms or natural language query

Preprocessing: Tokenization, cleaning

Model: Trained NLP classifier (Python or Java service)

Output: Predicted disease or response

📸 Screenshots

(Insert screenshots of Home, Chatbot, Disease Predictor, Profile, etc.)

🚀 Deployment

Flutter deployed on Android and iOS (AAB, APK)

Spring Boot backend deployed on Render / Heroku / VPS

ML service containerized via Docker (optional)

🧑‍💻 Authors

Vipul Kumar Gupta

Shashank Chaurasiya

