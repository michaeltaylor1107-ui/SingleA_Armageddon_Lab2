#!/bin/bash
# =============================================================================
# Lab 2: EC2 Startup Script (User Data Automation)
# Author: Brian Gray.
# Purpose: Automatically configure an EC2 instance to host a static website
# Web Server: Apache (httpd)
# =============================================================================

# -----------------------------------------------------------------------------
# STEP 1: System Update
# Ensures all packages are current before installing new software
# -----------------------------------------------------------------------------
yum update -y

# -----------------------------------------------------------------------------
# STEP 2: Install Apache Web Server
# httpd is the Apache package name on Amazon Linux
# -----------------------------------------------------------------------------
yum install -y httpd

# -----------------------------------------------------------------------------
# STEP 3: Start Apache and Enable Auto-Start on Boot
# systemctl start  → starts the service immediately
# systemctl enable → ensures it starts automatically after reboot
# -----------------------------------------------------------------------------
systemctl start httpd
systemctl enable httpd

# -----------------------------------------------------------------------------
# STEP 4: Create the HTML Web Page
# This writes a complete HTML file with inline CSS to the Apache web root
# The page includes: name, background image, embedded image, and 3 sections
# -----------------------------------------------------------------------------
cat <<'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Brian Gray. | EC2 Static Site</title>
    <style>
        /* ===== GLOBAL STYLES ===== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.8;
            color: #f0f0f0;
            background-image: url('https://www.bing.com/th/id/OIP.o0-_5Yz2Vr32GtIPXUKTLQHaEo?w=268&h=211&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            min-height: 100vh;
        }

        /* ===== OVERLAY FOR READABILITY ===== */
        .overlay {
            background-color: rgba(0, 0, 0, 0.7);
            min-height: 100vh;
            padding: 40px 20px;
        }

        /* ===== CONTAINER ===== */
        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        /* ===== HEADER ===== */
        header {
            text-align: center;
            padding: 40px 0;
            border-bottom: 2px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 40px;
        }

        header h1 {
            font-size: 3rem;
            color: #00d4ff;
            text-shadow: 0 0 20px rgba(0, 212, 255, 0.5);
            margin-bottom: 10px;
        }

        header p {
            font-size: 1.2rem;
            color: #b0b0b0;
            font-style: italic;
        }

        /* ===== CONTENT SECTIONS ===== */
        .section {
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .section h2 {
            color: #00d4ff;
            font-size: 1.8rem;
            margin-bottom: 15px;
            border-left: 4px solid #00d4ff;
            padding-left: 15px;
        }

        .section p {
            font-size: 1.1rem;
            color: #e0e0e0;
        }

        /* ===== EMBEDDED IMAGE ===== */
        .image-container {
            text-align: center;
            margin: 30px 0;
        }

        .image-container img {
            max-width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            border: 2px solid rgba(0, 212, 255, 0.3);
        }

        .image-container p {
            margin-top: 10px;
            font-size: 0.9rem;
            color: #888;
            font-style: italic;
        }

        /* ===== FOOTER ===== */
        footer {
            text-align: center;
            padding: 30px 0;
            margin-top: 40px;
            border-top: 2px solid rgba(255, 255, 255, 0.2);
        }

        footer p {
            color: #888;
            font-size: 1rem;
        }

        footer .copyright {
            margin-top: 15px;
            font-size: 0.9rem;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="overlay">
        <div class="container">
            
            <!-- HEADER WITH NAME -->
            <header>
                <h1>Brian Gray.</h1>
                <p>IWGP Champion | Investor | Membership Privileges</p>
            </header>

            <!-- SECTION 1: ABOUT ME -->
            <section class="section">
                <h2>About Me</h2>
                <p>Become the Jedi they've heard of...but never seen.</p>
            </section>

            <!-- EMBEDDED IMAGE -->
            <div class="image-container">
                <img src="https://th.bing.com/th/id/R.5b062ef1a1efbcbbedcc4249b733b89b?rik=I3h7A4ysnV2QKg&riu=http%3a%2f%2fgetwallpapers.com%2fwallpaper%2ffull%2f0%2fa%2f0%2f1381157-beautiful-sith-lord-wallpaper-1920x1080-download.jpg&ehk=i7IcLpCB0T6lqEQQQsVl781Ddu4bhjAp%2fQ8KBTv7Q2s%3d&risl=&pid=ImgRaw&r=0">
                <p>The Light Within — Matrix of Leadership</p>
            </div>

            <!-- SECTION 2: PROJECT DESCRIPTION -->
            <section class="section">
                <h2>Project Description</h2>
                <p>This lab introduces Linux automation and cloud initialization by writing a startup script that configures an EC2 instance to host a front-facing static website.</p>
            </section>

            <!-- SECTION 3: CONTACT -->
            <section class="section">
                <h2>Contact</h2>
                <p>Questions, collaborations, or inquiries? Shine the bat signal.</p>
            </section>

            <!-- FOOTER -->
            <footer>
                <p>&copy; 2026 EleMENTALS &mdash; Its only dark in the beginning.</p>
            </footer>

        </div>
    </div>
</body>
</html>
EOF

# -----------------------------------------------------------------------------
# STEP 5: Set Correct Permissions
# Ensures Apache can read and serve the HTML file
# -----------------------------------------------------------------------------
chmod 644 /var/www/html/index.html

# -----------------------------------------------------------------------------
# Script Complete - Web server is now running and serving the static page
# Access via: http://<EC2-Public-IP>
# -----------------------------------------------------------------------------
