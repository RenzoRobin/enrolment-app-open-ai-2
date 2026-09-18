#!/usr/bin/env bash
# Verifies Lab 04 + Lab 05 prerequisites required before starting Lab 07.
set -u
APP_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$APP_DIR/.." && pwd)"
PASS=0
FAIL=0

check() {
  local desc="$1"
  local path="$2"
  if [ -e "$path" ]; then
    echo "PASS: $desc"
    PASS=$((PASS+1))
  else
    echo "FAIL: $desc (missing: $path)"
    FAIL=$((FAIL+1))
  fi
}

echo "== Lab 04 artifacts =="
check "docker-compose.yml" "$APP_DIR/docker-compose.yml"
check "frontend-service" "$APP_DIR/frontend-service"
check "enrolment-service" "$APP_DIR/enrolment-service"
check "database-service" "$APP_DIR/database-service"
check "legacy-lab3/enrolment.db" "$APP_DIR/legacy-lab3/enrolment.db"

echo
echo "== Lab 05 artifacts =="
check ".github/workflows/lab5-ci.yml (repo root)" "$REPO_ROOT/.github/workflows/lab5-ci.yml"
check "reports/report.json" "$APP_DIR/reports/report.json"
check "reports/report.md" "$APP_DIR/reports/report.md"
check "reports/run-view.md" "$APP_DIR/reports/run-view.md"

if [ -f "$APP_DIR/reports/report.json" ] && grep -q PLACEHOLDER "$APP_DIR/reports/report.json"; then
  echo "WARN: reports/report.json still contains placeholder values - run the lab5-ci workflow_dispatch and replace it with the real artifact."
fi

echo
echo "== Docker / Ollama =="
if command -v docker >/dev/null 2>&1; then echo "PASS: docker installed"; PASS=$((PASS+1)); else echo "FAIL: docker not found"; FAIL=$((FAIL+1)); fi
if command -v ollama >/dev/null 2>&1; then echo "PASS: ollama installed"; PASS=$((PASS+1)); else echo "FAIL: ollama not found"; FAIL=$((FAIL+1)); fi

echo
echo "Result: $PASS passed, $FAIL failed"
