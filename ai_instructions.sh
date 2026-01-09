init_ai_simple() {

}

init_ai() {
  # Defaults
  local concise="normal"
  local agency="reactive"
  local lens="general"
  local dir="ai_instructions"
  local file="$dir/instructions.md"

  # Parse args
  while [ $# -gt 0 ]; do
    case "$1" in
    --concise)
      concise="$2"
      shift 2
      ;;
    --agency)
      agency="$2"
      shift 2
      ;;
    --lens)
      lens="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1"
      echo "Usage: init_ai [--concise brief|normal|detailed] [--agency reactive|suggestive|autonomous] [--lens backend|systems|ml|philosophy|product|general]"
      return 1
      ;;
    esac
  done

  mkdir -p "$dir" || return 1

  # ---- Base block ----
  cat >"$file" <<EOF
# AI Agent Instructions

**Author**: Dillon Ansah  
**Context**: CLI-based AI agent behavior  
**Generated**: $(date +%Y-%m-%d)

---

## Non-negotiables
- Be correct over confident. State assumptions if needed.
- Prefer actionable outputs: commands, diffs, checklists.
- Do not create extra documents unless explicitly requested.
- Ask **one** clarifying question only if progress is blocked.
EOF

  # ---- Conciseness block ----
  case "$concise" in
  brief)
    cat >>"$file" <<'EOF'

## Default Response Length: BRIEF
- Default to 3–7 bullets or ≤ 8 lines.
- Lead with the answer; minimal explanation.
- Limit options to 2–3 with one-line tradeoffs.
EOF
    ;;
  normal)
    cat >>"$file" <<'EOF'

## Default Response Length: NORMAL
- Short paragraphs plus bullets.
- Include just enough context to act.
- Options may include brief tradeoffs.
EOF
    ;;
  detailed)
    cat >>"$file" <<'EOF'

## Default Response Length: DETAILED
- Structured explanations with headings and bullets.
- Include rationale, edge cases, and next steps.
- Avoid essays; optimize for clarity.
EOF
    ;;
  *)
    echo "Invalid --concise value: $concise"
    return 1
    ;;
  esac

  # ---- Agency block ----
  case "$agency" in
  reactive)
    cat >>"$file" <<'EOF'

## Agency: REACTIVE
- Answer exactly what is asked.
- Do not add unsolicited suggestions.
- Warn briefly if something is risky or incorrect.
EOF
    ;;
  suggestive)
    cat >>"$file" <<'EOF'

## Agency: SUGGESTIVE
- Answer the question directly.
- Then provide 1–3 optional improvements or next steps.
- Keep additions clearly marked as optional.
EOF
    ;;
  autonomous)
    cat >>"$file" <<'EOF'

## Agency: AUTONOMOUS
- Make reasonable assumptions and proceed.
- Propose a short plan for multi-step tasks.
- Ask questions only if required to avoid mistakes.
EOF
    ;;
  *)
    echo "Invalid --agency value: $agency"
    return 1
    ;;
  esac

  # ---- Domain lens block ----
  case "$lens" in
  backend)
    cat >>"$file" <<'EOF'

## Domain Lens: BACKEND ENGINEERING
Focus on APIs, data models, auth, validation, and reliability.
Consider error handling, contracts, and maintainability.
EOF
    ;;
  systems)
    cat >>"$file" <<'EOF'

## Domain Lens: SYSTEMS
Focus on performance, memory, concurrency, and low-level tradeoffs.
Mention time/space complexity when relevant.
EOF
    ;;
  ml)
    cat >>"$file" <<'EOF'

## Domain Lens: ML / DATA SCIENCE
Focus on data quality, leakage, baselines, and evaluation.
State assumptions and validation strategy.
EOF
    ;;
  philosophy)
    cat >>"$file" <<'EOF'

## Domain Lens: PHILOSOPHY
Focus on clear definitions, argument structure, and objections.
Distinguish conceptual vs empirical claims.
EOF
    ;;
  product)
    cat >>"$file" <<'EOF'

## Domain Lens: PRODUCT / UX
Focus on user journeys, scope, tradeoffs, and requirements.
Surface risks and adoption concerns.
EOF
    ;;
  general)
    cat >>"$file" <<'EOF'

## Domain Lens: GENERAL
Optimize for clarity, correctness, and practicality.
EOF
    ;;
  *)
    echo "Invalid --lens value: $lens"
    return 1
    ;;
  esac

  echo "init_ai: generated $file"
}

init_ai_help() {
  cat <<'EOF'
init_ai — AI instruction initializer (modular, argument-driven)

USAGE:
  init_ai [OPTIONS]

DESCRIPTION:
  Initializes an AI instruction file by composing modular prompt blocks.
  The final prompt is built by concatenating:

    1) Base instructions (always included)
    2) Conciseness block
    3) Agency block
    4) Domain lens block

  Each block is selected via command-line arguments.

OPTIONS:

  --concise <level>
    Controls default response length and verbosity.

    Valid values:
      brief     → very short responses (3–7 bullets, minimal explanation)
      normal    → balanced length (default)
      detailed  → thorough, structured explanations

    Default:
      normal

  --agency <mode>
    Controls how proactive the AI agent is.

    Valid values:
      reactive    → answer only what is asked
      suggestive  → answer + 1–3 optional suggestions
      autonomous  → make assumptions, propose plans, proceed unless blocked

    Default:
      reactive

  --lens <domain>
    Biases the AI toward a specific domain mindset.

    Valid values:
      general      → neutral, practical (default)
      backend      → APIs, data models, auth, reliability
      systems      → performance, memory, concurrency
      ml           → data quality, evaluation, leakage
      philosophy   → definitions, arguments, objections
      product      → user journeys, scope, tradeoffs

    Default:
      general

EXAMPLES:

  Minimal (all defaults):
    init_ai

  Terse, proactive backend agent:
    init_ai --concise brief --agency autonomous --lens backend

  Careful philosophy explainer:
    init_ai --concise detailed --agency reactive --lens philosophy

  Practical ML collaborator:
    init_ai --concise normal --agency suggestive --lens ml

NOTES:
- Arguments are independent and composable.
- The generated instructions file reflects the chosen configuration.
- Re-running init_ai overwrites the existing instructions file.

TIP:
  Treat init_ai as a "prompt compiler":
  flags describe *how the AI should behave*, not what it should say.

EOF
}
