"""Database reset utility for EduTrack.

Wipes all tables in the configured database (local SQLite or remote PostgreSQL)
and re-seeds the initial starting dataset, restoring the default admin credentials
and demo accounts.
"""

import os
import sys

# Ensure base directory is on sys.path
BASE_DIR = os.path.abspath(os.path.dirname(__file__))
if BASE_DIR not in sys.path:
    sys.path.insert(0, BASE_DIR)

from app import create_app, seed_database
from app.models import db, User


def reset_database():
    env = os.environ.get("FLASK_ENV", "dev")
    app = create_app(env)

    with app.app_context():
        db_uri = app.config.get("SQLALCHEMY_DATABASE_URI", "")
        # Mask credentials in output if remote URI
        masked_uri = db_uri
        if "@" in masked_uri:
            prefix, rest = masked_uri.split("@", 1)
            scheme = prefix.split("://")[0]
            masked_uri = f"{scheme}://****:****@{rest}"

        print(f"[*] Resetting database for environment: '{env}'")
        print(f"[*] Target Database: {masked_uri}")

        # Drop all tables
        print("[*] Dropping all existing tables...")
        db.drop_all()

        # Recreate all tables
        print("[*] Creating fresh tables...")
        db.create_all()

        # Re-seed initial data
        print("[*] Seeding starting dataset...")
        seed_database(app)

        print("\n" + "=" * 60)
        print("  SUCCESS: Database has been reset to starting state!")
        print("=" * 60)
        print("All custom/modified data has been cleared.")
        print("\nRestored Admin Credentials:")
        print("  Email:    admin@edutrack.com")
        print("  Password: demo123")
        print("\nRestored Test Accounts (Password: demo123):")
        print("  Teacher:  teacher@edutrack.com")
        print("  Student:  student@edutrack.com")
        print("  Parent:   parent@edutrack.com")
        print("=" * 60 + "\n")


if __name__ == "__main__":
    reset_database()
