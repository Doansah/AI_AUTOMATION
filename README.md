# Automating AI_Instructions 

A common problem I have with AI models is their tendency to be overly verbose and to generate unnecessary `.md` files that bloat a codebase and quietly waste tokens over time. It honestly drives me mad. To avoid this, I wrote a small set of shell functions that generate a custom `instructions.md` file to explicitly control how an LLM behaves in a given folder or project.

The idea is simple: **configure AI behavior once, instead of constantly re-prompting it**.

---

## How it works

The `init_ai` function generates an `instructions.md` file by composing a few modular prompt blocks:

1. **Base instructions** (always included)
2. **Conciseness**
3. **Agency**
4. **Domain lens**

The final prompt is just the concatenation of these blocks. Different arguments select different blocks, which lets you tune the AI’s behavior without changing your workflow.

---

## Configuration options

### Conciseness

Controls default response length.

* `brief` – very short, direct answers
* `normal` – balanced (default)
* `detailed` – step-by-step explanations

### Agency

Controls how proactive the AI is.

* `reactive` – answer only what’s asked (i love this one)
* `suggestive` – answer + small optional suggestions
* `autonomous` – make assumptions and proceed unless blocked

### Domain lens

Biases how the AI thinks.

* `general` (default)
* `backend`
* `systems`
* `ml`
* `philosophy`
* `product`

---

## Example Use Cases

```bash
init_ai
```

Generate instructions with all defaults.

```bash
init_ai --concise brief --agency autonomous --lens backend
```

Terse, proactive backend-focused agent.

```bash
init_ai --concise detailed --agency reactive --lens product
```

Careful, step-by-step product explainer.

## Helper Functions & More



1) I've also added a init_ai_help() function, if you'd like to view all the configuration options in the terminal.

2) I actually use these in in my ZSH Config, but I've ported it over here to not bloat that readme. If you want to have a fly shell config check it out.

3) If you'd like to see the prompts themselves view the `prompt.txt` file. 

4) Guys, don't waste your tokens.
