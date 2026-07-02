# EduTrack: Next-Gen Campus Operations Platform

EduTrack is an advanced, all-in-one educational institution management platform. It seamlessly connects administrators, teachers, students, and parents with powerful tools including **Smart Biometrics**, **Real-Time Analytics**, and **Automated Early Warning Systems (EWS)**.

## 🚀 Key Features

- **🛡️ High-Security Authentication**: Role-Based Access Control (RBAC), secure session management, hashed passwords, and OTP-based email verification.
- **📸 Smart Biometrics (Face Recognition)**: Verify attendance instantly using coordinate-bounded GPS geo-fencing combined with Face Recognition.
- **🚨 Early Warning System (EWS)**: Automatically flags students who are at risk (low attendance or poor academics) and notifies relevant parties.
- **📊 Real-Time Analytics**: Interactive attendance trends, subject performance grids, and placement rate metrics.
- **✉️ Unified Portals & Messaging**: Tailored access roles for Admins, Teachers, Students, and Parents. Direct in-app data channels and email integration via EmailJS.
- **💰 Seamless Finance**: Transparent digital pipelines for tracking fee deposits and managing salary disbursements.

## 🛠️ Tech Stack

- **Backend Architecture**: Python 3, Flask, SQLAlchemy (ORM)
- **Database**: SQLite (Development) / PostgreSQL (Production ready)
- **Security**: Flask-Limiter (Rate Limiting), Werkzeug Security (Argon2/Bcrypt Password Hashing)
- **Frontend**: Vanilla JavaScript (Minified & Obfuscated for security), Plus Jakarta Sans, Lucide Icons, Chart.js
- **Environment**: Gunicorn & Docker ready

## ⚡ Quick Start Guide

### Prerequisites
- Python 3.10 or higher
- Git

### Installation Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/hrishav2208/Edutrack.git
   cd Edutrack
   ```

2. **Set up a Virtual Environment:**
   ```bash
   # Windows
   python -m venv venv
   venv\Scripts\activate
   
   # macOS/Linux
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install Dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Environment Configuration:**
   Copy the sample environment file to `.env`:
   ```bash
   # Windows
   copy .env.example .env
   
   # macOS/Linux
   cp .env.example .env
   ```
   *Note: Open `.env` and fill in your EmailJS credentials to enable OTP/Email notifications.*

5. **Initialize Database & Insert Test Users:**
   *(Ensure you run this to populate the system with demo accounts!)*
   ```bash
   python insert_users.py
   ```

6. **Run the Application:**
   ```bash
   # Windows users can simply double-click or run:
   run.bat
   
   # Or manually:
   python wsgi.py
   ```
   The platform will be available at `http://127.0.0.1:5000`

## 🔑 Default Test Credentials

If you ran `insert_users.py`, the following demo accounts are available. 
**The default password for ALL accounts is:** `Welcome@123`

| Role    | Name | Login ID (UID or Email) |
| -------- | ------- |-------|
| Teacher | Andrew Tate | `EMP-AI26AND001` or `andrew33@gmail.com` |
| Teacher | Hrishav Bisht | `EMP-AI26HRI001` or `hrishav888@gmail.com` |
| Student | Wilson Gaikwad | `STU-AIM26WIL001` or `wilsongaikwad@gmail.com` |
| Parent  | Sanjay Gaikwad | `PAR-26SAN001` or `sanjay@gmail.com` |

## 📁 Project Structure

```text
Edutrack/
├── app/                  # Application core package
│   ├── attendance.py     # Attendance & Biometric endpoints
│   ├── auth.py           # Authentication, Rate Limiting, RBAC
│   ├── models.py         # SQLAlchemy DB models (User, Student, etc.)
│   ├── face_recognition.py # Core logic for Face ID / Distance calculations
│   └── services/
│       └── ews_engine.py # Early Warning System cron/engine logic
├── static/               # CSS and Obfuscated JS (main.min.js)
├── templates/            # HTML structural templates
├── insert_users.py       # DB Seeding Script
└── README.md             # This file
```

## 🔒 Security Best Practices Implemented

This system takes privacy and security seriously:
- **Backend Logic Enforcement:** All biometric calculations and authorization decisions are handled completely server-side. The frontend is never trusted with critical state decisions.
- **Frontend Obfuscation:** The client-side JavaScript (`main.min.js`) is minified and obfuscated to prevent trivial reverse-engineering via DevTools.
- **Session Protections:** Secure session cookies paired with rate-limiters on sensitive endpoints (e.g., login, OTP requests).
- **Encrypted Passwords:** No plaintext passwords exist in the database.

## 📄 Documentation

Technical documentation can be generated on the fly as a PDF using the bundled generator tool:
```bash
python generate_docs_pdf.py
```
This script outputs `EduTrack_Technical_Documentation.pdf` outlining structural components and architecture guidelines.

## ⚖️ License
Distributed under the MIT License. See `LICENSE` for more information.
