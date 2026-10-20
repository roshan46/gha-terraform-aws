import datetime
import json

today = datetime.date.today()
for item in json.load(open("security-exceptions.json", encoding="utf-8"))["exceptions"]:
    assert all(item.get(k) for k in ("id", "component", "reason", "owner", "expires")), "Incomplete exception"
    assert datetime.date.fromisoformat(item["expires"]) >= today, f"Expired exception: {item['id']}"
print("Exception records are complete and unexpired")
