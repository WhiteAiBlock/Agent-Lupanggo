#!/usr/bin/env bash
# Ralph Wiggum Autonomous Loop
# Continuously picks tasks from PRD.md, executes them via agent, and repeats until complete.

set -e

MAX_ITER=${1:-50}
PROMPT_FILE="scripts/ralph/prompt.md"
PRD_FILE="PRD.md"
COMPLETE_SIGNAL="LOOP_COMPLETE"

echo "=========================================="
echo "Starting Ralph Autonomous Loop"
echo "Max iterations: $MAX_ITER"
echo "=========================================="

iter=0
while [ $iter -lt $MAX_ITER ]; do
  echo ""
  echo ">>> Iteration $iter of $MAX_ITER"
  
  # Check if loop should terminate
  if grep -q "$COMPLETE_SIGNAL" "$PROMPT_FILE" 2>/dev/null; then
    echo "[RALPH] Task marked complete. Exiting loop."
    break
  fi
  
  # Check if all PRD tasks are done
  if [ -f "$PRD_FILE" ]; then
    unchecked=$(grep -c "^\- \[ \]" "$PRD_FILE" || true)
    if [ "$unchecked" -eq 0 ]; then
      echo "[RALPH] All PRD tasks completed. Exiting loop."
      break
    fi
  fi
  
  echo "[RALPH] Running agent iteration $iter..."
  
  # Invoke the agent via GitHub Copilot or your AI CLI
  # Replace this with your actual agent invocation command
  # Examples:
  #   - gh copilot explain < "$PROMPT_FILE"
  #   - ai-cli run --prompt-file "$PROMPT_FILE"
  #   - curl -X POST -d @"$PROMPT_FILE" https://api.your-agent.com/run
  
  # For now, log that agent was invoked
  echo "[RALPH] Agent execution placeholder (Copilot will handle this)"
  
  # Sleep briefly between iterations to avoid rate limiting
  sleep 5
  
  iter=$((iter + 1))
done

echo ""
echo "=========================================="
echo "Ralph Loop Complete"
echo "Iterations: $iter"
echo "=========================================="
