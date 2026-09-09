# Development Notes

## Project Setup
- Ensure Python 3.10+ is installed
- Install dependencies with pip install -r requirements.txt
- Configure environment variables in .env

## Database Configuration
- PostgreSQL recommended for production
- SQLite used for local development

## API Endpoints
- GET /api/students - List all students
- POST /api/attendance - Mark attendance
- GET /api/timetable - Fetch timetable
- PUT /api/profile - Update profile

## Mobile App
- Built with Flutter/Dart
- Minimum SDK: Android 21, iOS 12

## Testing
- Run unit tests: python -m pytest
- Run flutter tests: flutter test

## Deployment Checklist
- [ ] Run all tests
- [ ] Update version number
- [ ] Check environment variables
- [ ] Build production assets
- [ ] Verify database migrations
- [ ] Test on staging server

## Code Style
- Follow PEP 8 for Python code
- Use Dart formatting standards for Flutter
- Keep functions under 30 lines when possible

## Known Issues
- Timetable sync may delay on slow connections
- Push notifications require FCM setup
