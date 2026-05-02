import json
import time
import random
import re
import os
from datetime import datetime
from pathlib import Path
import requests
from bs4 import BeautifulSoup

SCRIPT_DIR = Path("E:/Rahul/Softwares/AI Gym Mentor/AI Gym Mentor/dev")
BASE_DIR = SCRIPT_DIR.parent
OUTPUT_DIR = BASE_DIR / "dev" / "archive" / "jefit_scrape_results"
OUTPUT_DIR.mkdir(exist_ok=True, parents=True)

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language": "en-US,en;q=0.5",
    "Connection": "keep-alive",
}
BASE_URL = "https://www.jefit.com"

def delay():
    time.sleep(random.uniform(1.0, 2.5))

def get_page(url, retries=3):
    for i in range(retries):
        try:
            delay()
            r = requests.get(url, headers=HEADERS, timeout=30)
            r.raise_for_status()
            return BeautifulSoup(r.content, "html.parser")
        except Exception as e:
            print(f"  Attempt {i+1} failed: {e}")
            if i == retries - 1:
                return None
            time.sleep(2 ** i)
    return None

def scrape_list_page(page_num):
    url = f"{BASE_URL}/exercises?page={page_num}" if page_num > 0 else f"{BASE_URL}/exercises"
    print(f"List page {page_num}...")
    soup = get_page(url)
    if not soup:
        return []
    exercises = []
    seen = set()
    for a in soup.find_all("a", href=True):
        m = re.match(r"/exercises/(\d+)/", a["href"])
        if m:
            jid = int(m.group(1))
            if jid in seen:
                continue
            seen.add(jid)
            title = a.find(["h2", "h3", "h4"])
            if title:
                name = title.get_text(strip=True)
            else:
                txt = a.get_text(strip=True)
                if 5 < len(txt) < 100:
                    name = txt
                else:
                    img = a.find("img")
                    name = img.get("alt", "").replace(" Demonstration", "") if img else "Unknown"
            name = re.sub(r"\s+Demonstration$", "", name).strip()
            sub = ""
            for t in ["Back", "Chest", "Shoulders", "Legs", "Arms", "Core", "Cardio"]:
                if a.find(string=re.compile(t, re.I)):
                    sub = a.get_text(strip=True)
                    break
            exercises.append({"id": jid, "name": name, "subtext": sub, "url": BASE_URL + a["href"]})
    print(f"  Found {len(exercises)}")
    return exercises

def scrape_detail(info):
    print(f"Detail: {info['name']} ({info['id']})", end=" ")
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
        for e in parent.find_all_next(["a", "span"], limit=10):
            t = e.get_text(strip=True)
            if t and len(t) < 30 and not re.search(r"^(Diff|Equip|Type|Log)", t):
                mlist.append(t)
            if e.find_next(string=re.compile(r"Equipment|Difficulty", re.I)):
                break
        if mlist:
            muscle = " / ".join(mlist)
    elif info["subtext"]:
        muscle = info["subtext"]
    equip = "Unknown"
    es = soup.find(string=re.compile(r"Equipment", re.I))
    if es:
        t = es.parent.find_next(string=True)
        if t and len(t.strip()) < 50:
            equip = t.strip()
    else:
        for kw in ["Barbell", "Dumbbell", "Machine", "Cable", "Body Weight", "Bench", "Kettlebell"]:
            if kw.lower() in soup.get_text().lower():
                equip = kw
                break
    diff = "Intermediate"
    ds = soup.find(string=re.compile(r"Difficulty", re.I))
    if ds:
        t = ds.parent.find_next(string=True)
        if t:
            dt = t.strip().lower()
            if "beginner" in dt:
                diff = "Beginner"
            elif "advanced" in dt or "expert" in dt:
                diff = "Advanced"
    ex_type = "Strength"
    ts = soup.find(string=re.compile(r"Type", re.I))
    if ts:
        t = ts.parent.find_next(string=True)
        if t:
            tt = t.strip().lower()
            if "stretching" in tt or "flexib" in tt:
                ex_type = "Stretching"
            elif "cardio" in tt:
                ex_type = "Cardio"
    log = "weight and reps"
    ls = soup.find(string=re.compile(r"Log Type", re.I))
    if ls:
        t = ls.parent.find_next(string=True)
        if t:
            log = t.strip()
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
            if cur and cur.name in ["h1", "h2", "h3"]:
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

all_infos = []
for p in range(72):
    exs = scrape_list_page(p)
    if not exs:
        print(f"Stop {p}")
        break
    all_infos.extend(exs)
    print(f"Total: {len(all_infos)}")
    if p < 5 or p % 10 == 0:
        with open(OUTPUT_DIR / "exercise_list.json", "w", encoding="utf-8") as f:
            json.dump(all_infos, f, indent=2, ensure_ascii=False)

print(f"\\nTotal exercises: {len(all_infos)}")
with open(OUTPUT_DIR / "exercise_list.json", "w", encoding="utf-8") as f:
    json.dump(all_infos, f, indent=2, ensure_ascii=False)

print(f"\\nScraping details...")
all_details = []
for i, info in enumerate(all_infos):
    print(f"[{i+1}/{len(all_infos)}]", end="")
    d = scrape_detail(info)
    if d:
        all_details.append(d)
    if (i + 1) % 50 == 0:
        with open(OUTPUT_DIR / ("details_" + str(len(all_details)) + ".json"), "w", encoding="utf-8") as f:
            json.dump(all_details, f, indent=2, ensure_ascii=False)

with open(OUTPUT_DIR / "jefit_exercises_complete.json", "w", encoding="utf-8") as f:
    json.dump(all_details, f, indent=2, ensure_ascii=False)

print(f"\\nDone! {len(all_details)} exercises scraped")
