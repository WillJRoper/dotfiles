# Agent Catalog

This directory defines custom OpenCode agents, each with a focused role, prompt, and model.

## Agents

- `alt-coordinator`: Alternate coordinator for planning/delegation when limits are tight; model `openai/gpt-5.2`.
- `arxiv`: Retrieves arXiv papers and writes structured literature notes to Obsidian; model `openai/gpt-5.2`.
- `brain-auditor`: Audits and improves second-brain link structure, including MOCs and backlinks; model `openai/gpt-5.2`.
- `coder`: Primary implementation agent for writing and modifying code under coordinator direction; model `openai/gpt-5.2`.
- `coder-backup`: Backup coding agent used when primary coding capacity or limits are hit; model `openai/gpt-5.2`.
- `coordinator`: Main orchestration agent for planning, sequencing, and delegation across specialists; model `openai/gpt-5.2`.
- `critic`: Reviews documentation from the intended audience perspective and identifies clarity gaps; model `openai/gpt-5.2`.
- `docs-writer`: Produces and maintains technical documentation for tools, configs, and workflows; model `openai/gpt-5.2`.
- `expert-computational-astrophysics`: Domain expert for computational astrophysics concepts and workflows; model `openai/gpt-5.2`.
- `expert-cosmology`: Domain expert for cosmology concepts, models, and interpretation; model `openai/gpt-5.2`.
- `expert-galaxy-formation`: Domain expert for galaxy formation and evolution topics; model `openai/gpt-5.2`.
- `expert-me`: Domain expert on Will Roper's background, work, and accomplishments; model `openai/gpt-5.2`.
- `expert-ml-techniques`: Domain expert for machine learning methods and practical technique selection; model `openai/gpt-5.2`.
- `expert-numerical-methods`: Domain expert for numerical methods, stability, and solver choices; model `openai/gpt-5.2`.
- `expert-sbi`: Domain expert for simulation-based inference methods and tooling; model `openai/gpt-5.2`.
- `researcher`: General research and synthesis agent for gathering and summarizing information; model `openai/gpt-5.2`.
- `reviewer`: Runs CodeRabbit CLI in prompt-only mode and summarizes findings; model `openai/gpt-5.2`.
- `test-scaffold`: Adds tests and scaffolding to verify behavior and reduce regressions; model `openai/gpt-5.2`.
