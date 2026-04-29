
import json
import time
import random
import re
from datetime import datetime
from pathlib import Path
import requests
from bs4 import BeautifulSoup

SCRIPT_DIR = Path("E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/dev")
BASE_DIR = SCRIPT_DIR.parent
OUTPUT_DIR = BASE_DIR / "dev" / "archive" / "jefit_scrape_results"

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language": "en-US,en;q=0.5",
    "Connection": "keep-alive",
}
BASE_URL = "https://www.jefit.com"

def delay():
    time.sleep(random.uniform(1.5, 3.0))

def get_page(url, retries=3):
    for i in range(retries):
        try:
            delay()
            r = requests.get(url, headers=HEADERS, timeout=30)
            r.raise_for_status()
            return BeautifulSoup(r.content, "html.parser")
        except Exception as e:
            print("  Attempt " + str(i+1) + " failed: " + str(e))
            if i == retries - 1:
                return None
            time.sleep(2 ** i)
    return None

with open(str(OUTPUT_DIR / "exercise_list.json"), encoding="utf-8") as f:
    all_infos = json.load(f)

print("Loaded " + str(len(all_infos)) + " exercises from list")

with open(str(BASE_DIR / "assets" / "data" / "exercises.json"), encoding="utf-8") as f:
    existing_exercises = json.load(f)

print("Loaded " + str(len(existing_exercises)) + " existing exercises")

def normalize_name(name):
    name = re.sub(r"\s+", " ", str(name)).strip()
    return name.lower()

existing_norm = {}
for e in existing_exercises:
    existing_norm[normalize_name(e.get("name",""))] = e

print("Unique normalized names in app: " + str(len(existing_norm)))

def scrape_detail(info):
    print("Scraping: " + info["name"] + " (" + str(info["id"]) + ")", end=" ")
    soup = get_page(info["url"])
    if not soup:
        print("FAIL")
        return None
    title = soup.find("h1")
    name = title.get_text(strip=True) if title else info["name"]
    name = re.sub(r"Try it out", "", name).strip()
    
    muscle = "Unknown"
    ms = soup.find(string=re.compile(r"Target Muscle", re.I))
    if ms:
        parent = ms.parent
        mlist = []
        for e in parent.find_all_next(["a","span"], limit=10):
            t = e.get_text(strip=True)
            if t and len(t) < 30 and not re.search(r"^(Diff|Equip|Type|Log)", t):
                mlist.append(t)
            if e.find_next(string=re.compile(r"Equipment|Difficulty", re.I)):
                break
        if mlist:
            muscle = " / ".join(mlist)
    elif info.get("subtext"):
        muscle = info["subtext"]
    
    equip = "Unknown"
    es = soup.find(string=re.compile(r"Equipment", re.I))
    if es:
        t = es.parent.find_next(string=True)
        if t and len(t.strip()) < 50:
            equip = t.strip()
    else:
        for kw in ["Barbell","Dumbbell","Machine","Cable","Body Weight","Bench","Kettlebell"]:
            if kw.lower() in soup.get_text().lower():
                equip = kw
                break
    
    diff = "Intermediate"
    ds = soup.find(string=re.compile(r"Difficulty", re.I))
    if ds:
        t = ds.parent.find_next(string=True)
        if t:
            dt = t.strip().lower()
            if "beginner" in dt: diff = "Beginner"
            elif "advanced" in dt or "expert" in dt: diff = "Advanced"
    
    ex_type = "Strength"
    ts = soup.find(string=re.compile(r"Type", re.I))
    if ts:
        t = ts.parent.find_next(string=True)
        if t:
            tt = t.strip().lower()
            if "stretching" in tt or "flexib" in tt: ex_type = "Stretching"
            elif "cardio" in tt: ex_type = "Cardio"
    
    log = "weight and reps"
    ls = soup.find(string=re.compile(r"Log Type", re.I))
    if ls:
        t = ls.parent.find_next(string=True)
        if t: log = t.strip()
    
    inst = []
    ins = soup.find(string=re.compile(r"Instructions|Steps", re.I))
    if ins:
        cur = ins.parent.find_next()
        n = 0
        while cur and n < 20:
            txt = cur.get_text(strip=True)
            if 20 < len(txt) < 1000:
                txt = re.sub(r"^\d+\.\s*", "", txt)
                txt = re.sub(r"^Step\s+\d+\s*[:.]?\s*", "", txt, flags=re.I)
                if not re.match(r"^(Alternative|Explore|Target)", txt):
                    inst.append(txt)
                    n += 1
            cur = cur.find_next()
            if cur and cur.name in ["h1","h2","h3"]:
                if re.search(r"Alternative|Explore", cur.get_text()):
                    break
    
    alt = []
    als = soup.find(string=re.compile(r"Alternative", re.I))
    if als:
        for a in als.parent.find_all_next("a", limit=20):
            at = a.get_text(strip=True)
            if at and len(at) < 50 and at not in alt:
                alt.append(at)
    
    print("OK")
    return {
        "jefit_id": info["id"],
        "name": name,
        "primary_muscle": muscle,
        "equipment": equip,
        "difficulty": diff,
        "exercise_type": ex_type,
        "instructions": inst,
        "log_type": log,
        "alternative_exercises": alt,
        "scrape_timestamp": datetime.utcnow().isoformat(),
    }

all_details = []
failed = []
for i, info in enumerate(all_infos):
    print("[" + str(i+1) + "/" + str(len(all_infos)) + "]", end="")
    d = scrape_detail(info)
    if d:
        all_details.append(d)
    else:
        failed.append(info)
    if (i+1) % 25 == 0:
        with open(str(OUTPUT_DIR / ("jefit_details_partial_" + str(i+1) + ".json")), "w", encoding="utf-8") as f:
            json.dump(all_details, f, indent=2, ensure_ascii=False)

with open(str(OUTPUT_DIR / "jefit_all_details.json"), "w", encoding="utf-8") as f:
    json.dump(all_details, f, indent=2, ensure_ascii=False)

with open(str(OUTPUT_DIR / "failed_jefit.json"), "w", encoding="utf-8") as f:
    json.dump(failed, f, indent=2)

print("\nDone! Scraped " + str(len(all_details)) + " exercises, " + str(len(failed)) + " failed")

