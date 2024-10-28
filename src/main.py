from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
import os

app = FastAPI()
templates = Jinja2Templates(directory="templates")

# Read version from version.txt
with open("version.txt") as version_file:
    version = version_file.read().strip()

# Main page
@app.get("/", response_class=HTMLResponse)
async def main_page(request: Request):
    return templates.TemplateResponse("index.html", {"request": request, "version": version})

# Health check endpoint
@app.get("/health")
async def health():
    return {"success": True}

# Run the application on port 80
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=80)
