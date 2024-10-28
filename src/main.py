from fastapi import FastAPI
from fastapi.responses import HTMLResponse
import json

app = FastAPI()

# Read version from version.txt
with open("version.txt") as version_file:
    version = version_file.read().strip()

# Main page
@app.get("/", response_class=HTMLResponse)
async def main_page():
    html_content = f"""
    <html>
    <head>
        <title>Main Page</title>
        <style>
            body {{ background-color: blue; color: white; }}
            h1 {{ color: red; text-align: center; }}
            footer {{ position: fixed; bottom: 0; width: 100%; text-align: center; }}
        </style>
    </head>
    <body>
        <h1>Learn GitHub Action</h1>
        <footer>Version: {version}</footer>
    </body>
    </html>
    """
    return HTMLResponse(content=html_content)

# Health check endpoint
@app.get("/health")
async def health():
    return {"success": True}